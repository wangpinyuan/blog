"""Generate the README catalog from Markdown titles and category labels."""

import html
import re
from collections import defaultdict
from pathlib import Path
from urllib.parse import quote

import yaml


START = "<!-- BLOG-POST-LIST:START -->"
END = "<!-- BLOG-POST-LIST:END -->"


def escape_markdown(value):
    return re.sub(r"([\\`*_\[\]~])", r"\\\1", html.escape(value, quote=False))


def read_metadata(path):
    lines = path.read_text(encoding="utf-8-sig").splitlines()
    if not lines:
        return {}

    title_heading = re.fullmatch(r"##[ \t]+(.+)", lines[0])
    if title_heading:
        metadata = {"title": title_heading.group(1).strip()}
        next_line = next((line for line in lines[1:] if line.strip()), "")
        category_heading = re.fullmatch(r"###[ \t]+分类[ \t]+(.+)", next_line)
        if category_heading:
            metadata["labels"] = category_heading.group(1).strip()
        return metadata

    if lines[0].strip() != "---":
        return {}

    try:
        end = lines.index("---", 1)
    except ValueError as error:
        raise ValueError(f"{path.name} 的文章元数据缺少结束标记 ---") from error

    try:
        metadata = yaml.safe_load("\n".join(lines[1:end]))
    except yaml.YAMLError as error:
        raise ValueError(f"{path.name} 的文章元数据格式有误\n{error}") from error

    if metadata is None:
        return {}
    if not isinstance(metadata, dict):
        raise ValueError(f"{path.name} 的文章元数据应包含 title 和 labels 字段")
    return metadata


def update_readme(root):
    readme_path = root / "README.md"
    readme = readme_path.read_text(encoding="utf-8")
    if readme.count(START) != 1 or readme.count(END) != 1:
        raise ValueError("README.md 必须包含一组 BLOG-POST-LIST:START/END 标记")

    before, _, remainder = readme.partition(START)
    _, separator, after = remainder.partition(END)
    if not separator:
        raise ValueError("README.md 的 BLOG-POST-LIST:END 必须位于 START 之后")

    categories = defaultdict(list)
    posts = sorted((root / "_posts").rglob("*.md"))
    for path in posts:
        metadata = read_metadata(path)
        title = metadata.get("title") or path.stem
        category = metadata.get("labels") or "未分类"
        if not isinstance(title, str) or not isinstance(category, str):
            raise ValueError(f"{path.name} 的 title 和 labels 应为单行文本")
        if "\n" in title or "\n" in category:
            raise ValueError(f"{path.name} 的 title 和 labels 应为单行文本")

        title = title.strip() or path.stem
        category = category.strip() or "未分类"
        link = quote(path.relative_to(root).as_posix(), safe="/")
        categories[category].append(f"- [{escape_markdown(title)}]({link})")

    sections = []
    for category in sorted(categories, key=str.casefold):
        articles = "\n".join(categories[category])
        sections.append(f"### {escape_markdown(category)}\n\n{articles}")

    catalog = "\n\n".join(sections) or "暂无文章。"
    updated = f"{before}{START}\n\n{catalog}\n\n{END}{after}"
    if updated != readme:
        readme_path.write_text(updated, encoding="utf-8")
    print(f"已生成目录，共 {len(posts)} 个文章文件、{len(categories)} 个分类。")


if __name__ == "__main__":
    try:
        update_readme(Path(__file__).resolve().parents[1])
    except ValueError as error:
        raise SystemExit(str(error))
