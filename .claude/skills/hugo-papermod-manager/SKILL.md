---
name: hugo-papermod-manager
description: Hugo静态网站和PaperMod主题管理工具。当用户需要操作Hugo网站、管理PaperMod主题配置、创建内容、运行开发服务器或部署网站时使用此skill。特别适用于使用Hugo和PaperMod主题的个人博客、学术网站或作品集网站。
---

# Hugo & PaperMod主题管理器

## 概述

此skill提供Hugo静态网站生成器和PaperMod主题的常用命令、配置指南和工作流程。涵盖本地开发、内容创建、主题定制、构建部署等完整生命周期管理。

## 快速开始

### 环境检查
```bash
# 检查Hugo版本
hugo version

# 检查主题子模块状态
git submodule status

# 更新主题子模块
git submodule update --init --recursive
```

### 开发服务器
```bash
# 启动本地开发服务器（支持实时重载）
hugo server

# 使用Draft模式启动（不显示draft: true的内容）
hugo server -D

# 绑定到特定端口
hugo server -p 8080

# 构建并启动生产服务器
hugo && hugo server --environment production
```

### 内容管理
```bash
# 创建新的博客文章
hugo new posts/my-new-post.md

# 创建新的项目页面
hugo new projects/my-new-project.md

# 创建教程页面
hugo new tutorials/my-tutorial.md

# 使用特定archetype模板
hugo new posts/my-post.md --kind post
```

## 常用命令

### 构建网站
```bash
# 基本构建（输出到public目录）
hugo

# 构建并压缩（生产部署）
hugo --minify

# 构建指定环境
hugo --environment production

# 清理构建缓存
hugo --gc
```

### 内容操作
```bash
# 列出所有内容
hugo list all

# 列出草稿内容
hugo list drafts

# 列出过期内容
hugo list expired

# 列出未来内容
hugo list future
```

### 主题管理
```bash
# 更新PaperMod主题
cd themes/PaperMod
git pull origin main
cd ../..

# 或从项目根目录更新
git submodule update --remote themes/PaperMod

# 查看主题版本
git -C themes/PaperMod log -1 --oneline
```

## PaperMod主题配置

### 主题设置参考
PaperMod主题支持以下常见配置（在hugo.yaml中）：

```yaml
# 启用主题功能
params:
  # 显示阅读时间
  ShowReadingTime: true

  # 显示分享按钮
  ShowShareButtons: true

  # 显示代码复制按钮
  ShowCodeCopyButtons: true

  # 启用评论（支持Disqus、Utterances等）
  comments: true

  # 启用目录
  ShowToc: true

  # 启用面包屑导航
  ShowBreadCrumbs: true

  # 启用页面导航（上一篇/下一篇）
  ShowPostNavLinks: true

  # 启用相关文章
  ShowRelated: true

  # 启用页面字数统计
  ShowWordCount: true

  # 启用搜索功能
  enableSearch: true

  # 启用暗黑模式
  defaultDark: false

  # 启用多语言支持
  multilingualMode: true
```

### 自定义布局
如需覆盖主题模板，将文件复制到layouts目录：
```bash
# 复制文章单页模板
cp themes/PaperMod/layouts/_default/single.html layouts/_default/

# 复制列表模板
cp themes/PaperMod/layouts/_default/list.html layouts/_default/

# 复制主页模板
cp themes/PaperMod/layouts/_default/home.html layouts/_default/
```

## 部署工作流

### GitHub Pages部署
```bash
# 构建网站
hugo --minify

# 提交更改
git add .
git commit -m "更新网站内容"

# 推送到GitHub（触发Actions自动部署）
git push origin main

# 手动触发部署（如配置了workflow_dispatch）
gh workflow run hugo.yml
```

### 本地预览构建结果
```bash
# 构建网站
hugo --minify

# 使用Python简单HTTP服务器预览
cd public
python -m http.server 8000
# 或使用Node.js
npx serve -p 8000
```

## 故障排除

### 常见问题
1. **主题未加载**：确保主题子模块已初始化
   ```bash
   git submodule update --init --recursive
   ```

2. **页面未更新**：清理Hugo缓存
   ```bash
   hugo --gc
   rm -rf public resources
   ```

3. **图片未显示**：确保图片在static目录或使用相对路径

4. **构建错误**：检查YAML语法和front matter格式

### 调试命令
```bash
# 详细构建日志
hugo --verbose

# 调试模式（显示更多信息）
hugo --debug

# 构建但不渲染
hugo --buildDrafts --buildExpired --buildFuture
```

## 内容模板参考

### 博客文章模板
```yaml
---
title: "文章标题"
date: 2026-01-08T10:30:00+08:00
draft: true  # 设为false发布
tags: ["标签1", "标签2"]
categories: ["分类"]
summary: "文章摘要"
showToc: true
tocOpen: true
---

正文内容...
```

### 项目页面模板
```yaml
---
title: "项目名称"
date: 2026-01-08
draft: false
project: true
description: "项目描述"
tags: ["技术栈", "类别"]
links:
  - name: "GitHub"
    url: "https://github.com/username/repo"
  - name: "演示"
    url: "https://demo.example.com"
featured: true  # 是否在首页展示
---

项目详情...
```

## 工具脚本

此skill包含多个实用脚本，可简化Hugo网站管理工作：

### 开发服务器脚本 (`scripts/start-dev-server.sh`)
```bash
# 启动开发服务器
./scripts/start-dev-server.sh

# 使用选项
./scripts/start-dev-server.sh --port 8080 --bind 0.0.0.0 --with-drafts --open-browser

# 查看帮助
./scripts/start-dev-server.sh --help
```

### 生产构建脚本 (`scripts/build-production.sh`)
```bash
# 生产构建
./scripts/build-production.sh

# 带清理的构建
./scripts/build-production.sh --clean --verbose

# 性能测量
./scripts/build-production.sh --performance --git-info

# 查看帮助
./scripts/build-production.sh --help
```

### 内容创建脚本 (`scripts/create-content.sh`)
```bash
# 创建博客文章
./scripts/create-content.sh post "我的新文章" --tags "hugo,博客" --categories "技术"

# 创建项目页面
./scripts/create-content.sh project "我的项目" --publish --tags "react,nodejs"

# 创建教程
./scripts/create-content.sh tutorial "Hugo入门指南" --output-dir content/tutorials --edit

# 查看帮助
./scripts/create-content.sh --help
```

### 脚本使用说明
1. 确保脚本有执行权限：`chmod +x scripts/*.sh`
2. 在项目根目录运行脚本
3. 所有脚本都支持 `--help` 查看详细用法
4. 脚本会检查Hugo是否安装并提供友好错误信息

## 参考文档

### PaperMod配置参考 (`references/papermod-config-reference.md`)
包含PaperMod主题所有配置参数的详细说明，包括：
- 基本设置和显示功能
- 评论系统配置（Disqus、Utterances、Remark42）
- 搜索功能配置（Fuse、Algolia）
- 社交媒体和图片配置
- 多语言支持和高级配置

### Hugo命令参考 (`references/hugo-commands-reference.md`)
完整的Hugo命令参考，包括：
- 服务器和构建命令
- 内容管理和列表命令
- 配置调试和模块管理
- 部署优化和性能调优
- 故障排除和环境变量

## 模板资源

### 内容模板 (`assets/`)
- `post-template.md`：博客文章模板，包含完整front matter和结构化内容
- `project-template.md`：项目页面模板，包含技术栈、部署说明、项目成果等

使用模板：
```bash
# 复制模板到内容目录
cp assets/post-template.md content/posts/my-new-post.md

# 编辑模板变量
sed -i 's/{{title}}/我的文章标题/g' content/posts/my-new-post.md
```

## 最佳实践

1. **版本控制**：将整个Hugo项目（包括主题子模块）提交到Git
2. **内容组织**：使用清晰的目录结构（posts/, projects/, tutorials/等）
3. **图片管理**：将图片放在static/images/目录并使用相对路径
4. **定期更新**：定期更新Hugo和PaperMod主题版本
5. **备份配置**：备份hugo.yaml和自定义布局文件

## 扩展阅读

- [Hugo官方文档](https://gohugo.io/documentation/)
- [PaperMod主题文档](https://github.com/adityatelange/hugo-PaperMod/wiki)
- [GitHub Pages部署指南](https://gohugo.io/hosting-and-deployment/hosting-on-github/)