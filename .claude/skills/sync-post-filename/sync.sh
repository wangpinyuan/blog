#!/bin/bash
# Sync Post Filename Script
# 根据 frontmatter title 自动重命名 _posts/ 目录下的 markdown 文件

# 获取脚本所在目录的绝对路径
SCRIPT_SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SCRIPT_SOURCE" ]; do
    SCRIPT_DIR="$(cd -P "$(dirname "$SCRIPT_SOURCE")" && pwd)"
    SCRIPT_SOURCE="$(readlink "$SCRIPT_SOURCE")"
    [ -z "$SCRIPT_SOURCE" ] && break
    SCRIPT_SOURCE="$(cd "$(dirname "$SCRIPT_SOURCE")" && pwd)/$(basename "$SCRIPT_SOURCE")"
done
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_SOURCE")" && pwd)"
SKILLS_DIR="$(dirname "$SCRIPT_DIR")"
CLAUDE_DIR="$(dirname "$SKILLS_DIR")"
BLOG_DIR="$(dirname "$CLAUDE_DIR")"
POSTS_DIR="$BLOG_DIR/_posts"

# 提取 title 的函数
get_title() {
    local file="$1"
    # 提取 --- --- 之间的 title
    sed -n '/^---$/,/^---$/p' "$file" | grep '^title:' | head -1 | sed 's/^title: *//' | sed 's/^["'"'"']//' | sed 's/["'"'"']$//'
}

# 提取现有序号
get_existing_seq() {
    local filename="$1"
    echo "$filename" | grep -oE '^[0-9]+' | head -1
}

# 获取所有现有序号
get_all_seqs() {
    find "$POSTS_DIR" -maxdepth 1 -name "*.md" -type f | xargs -I {} basename {} | grep -oE '^[0-9]+' | sort -n
}

# 计算下一个可用序号
get_next_seq() {
    local max_seq=$(get_all_seqs | tail -1)
    echo $((max_seq + 1))
}

# 重命名文件
rename_post() {
    local old_file="$1"
    local new_file="$2"

    if [ "$old_file" != "$new_file" ]; then
        if [ -e "$new_file" ]; then
            echo "⚠️  目标文件已存在，跳过: $new_file"
            return 1
        fi
        mv "$old_file" "$new_file"
        echo "✅ 重命名: $(basename "$old_file") → $(basename "$new_file")"
    else
        echo "🔹 无需重命名: $(basename "$old_file")"
    fi
}

echo "📂 扫描 $POSTS_DIR 目录下的文章..."

# 获取下一个可用序号
next_seq=$(get_next_seq)
echo "下一个序号: $next_seq"

# 遍历所有 md 文件
for file in "$POSTS_DIR"/*.md; do
    [ -e "$file" ] || continue
    filename=$(basename "$file")

    # 获取 title
    title=$(get_title "$file")
    if [ -z "$title" ]; then
        echo "⚠️  无法从 $filename 提取 title，跳过"
        continue
    fi

    # 检查是否已有序号
    existing_seq=$(get_existing_seq "$filename")

    if [ -n "$existing_seq" ]; then
        # 已有序号，保留序号
        seq="$existing_seq"
        echo "📝 已有序号 $seq: $title"
    else
        # 无序号，分配新序号
        seq="$next_seq"
        next_seq=$((next_seq + 1))
        echo "🆕 新分配序号 $seq: $title"
    fi

    # 清理标题中的非法文件系统字符（仅移除不能用于文件名的字符）
    # 保留 & | ? 等常见字符，只移除 \ / : * " < > |
    safe_title=$(echo "$title" | sed 's/[\\/:*?"<>|]/_/g')

    # 构造新文件名
    new_filename=$(printf "%03d-%s.md" "$seq" "$safe_title")
    new_file="$POSTS_DIR/$new_filename"

    # 执行重命名
    rename_post "$file" "$new_file"
done

echo "✨ 完成!"
