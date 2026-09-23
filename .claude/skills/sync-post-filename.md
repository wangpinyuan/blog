---
name: sync-post-filename
description: 根据文章 title 自动同步文件名（序号-标题.md 格式）
---

# Sync Post Filename

根据 `_posts/` 目录下 Markdown 文件的 frontmatter `title`，自动重命名文件为 `序号-标题.md` 格式。

## 工作流程

1. 扫描 `_posts/` 目录下所有 `.md` 文件
2. 提取每个文件的 `title`（从 frontmatter `---` 中读取）
3. 检查文件是否已有序号前缀（如 `001-xxx.md`）
   - **已有序号**：保留序号，只更新标题部分
   - **无序号**：分配下一个可用序号（从最大序号 +1 开始）
4. 执行重命名

## 使用方式

当需要时，执行以下命令：

```bash
cd /Users/wangpinyuan/Documents/代码库/blog
chmod +x .claude/skills/sync-post-filename/sync.sh
.claude/skills/sync-post-filename/sync.sh
```

## 序号规则

- 从现有最大序号 +1 开始递增（如现有最大 `24`，则新文件分配 `25`）
- 序号格式：`3` 位数字，不足补零（如 `001`, `002`...）
- 已存在的序号不会被改变

## 示例

| 原文件名 | title | 新文件名 |
|---------|-------|---------|
| `ReactHooks.md` | React Hooks 入门指南 | `025-React Hooks 入门指南.md` |
| `24-浏览器组成部分及运行原理.md` | 浏览器工作原理 | `024-浏览器工作原理.md` |
