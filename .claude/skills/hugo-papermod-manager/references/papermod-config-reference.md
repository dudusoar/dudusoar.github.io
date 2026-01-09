# PaperMod主题配置参考

## 核心配置参数

### 基本设置
```yaml
params:
  # 网站环境（development/production）
  env: production

  # 网站描述
  description: "网站描述"

  # 作者
  author: "作者名"

  # 默认主题模式（auto/light/dark）
  defaultTheme: auto

  # 主页标题
  homeInfoParams:
    Title: "主页标题"
    Content: "主页内容描述"
```

### 显示功能
```yaml
params:
  # 显示阅读时间
  ShowReadingTime: true

  # 显示分享按钮
  ShowShareButtons: true

  # 显示代码复制按钮
  ShowCodeCopyButtons: true

  # 显示文章导航（上一篇/下一篇）
  ShowPostNavLinks: true

  # 显示面包屑导航
  ShowBreadCrumbs: true

  # 显示目录
  ShowToc: true

  # 默认展开目录
  tocOpen: false

  # 显示相关文章
  ShowRelated: true

  # 显示字数统计
  ShowWordCount: true
```

### 评论系统
```yaml
params:
  comments: true  # 启用评论

  # Disqus评论
  disqusShortname: "your-disqus-shortname"

  # Utterances评论（GitHub Issues）
  utterances:
    repo: "username/repo"
    issueTerm: "pathname"
    label: "comment"
    theme: "github-light"

  # Remark42评论
  remark42:
    host: "https://your-remark42-instance.com"
    site_id: "your-site-id"
    locale: "en"
```

### 搜索功能
```yaml
params:
  # 启用搜索
  enableSearch: true

  # 搜索类型（fuse/algolia）
  searchType: "fuse"

  # Algolia搜索配置
  algolia:
    appId: "your-app-id"
    apiKey: "your-api-key"
    indexName: "your-index-name"
```

### 社交媒体
```yaml
params:
  # 社交媒体图标
  socialIcons:
    - name: github
      url: "https://github.com/username"
    - name: linkedin
      url: "https://linkedin.com/in/username"
    - name: twitter
      url: "https://twitter.com/username"
    - name: email
      url: "mailto:email@example.com"
    - name: rss
      url: "index.xml"  # RSS订阅

  # 分享按钮配置
  shareButtons: ["twitter", "linkedin", "reddit", "facebook"]
```

### 图片配置
```yaml
params:
  # 封面图片
  cover:
    hidden: false  # 隐藏所有封面图片
    hiddenInList: false  # 只在列表页隐藏
    hiddenInSingle: false  # 只在单页隐藏

  # 默认封面图片
  defaultCover: "/path/to/default-cover.jpg"

  # 图片处理
  imageProcessing:
    cover:
      resizeOptions: "300x200"
    single:
      resizeOptions: "800x600"
```

### 页面元数据
```yaml
params:
  # 自定义元数据
  customMeta:
    - name: "keywords"
      content: "hugo, papermod, blog"
    - name: "author"
      content: "作者名"

  # Open Graph配置
  openGraph:
    image: "/path/to/og-image.jpg"
    type: "website"

  # Twitter卡片
  twitterCards:
    image: "/path/to/twitter-image.jpg"
    creator: "@username"
```

## 内容类型配置

### 文章配置
```yaml
# 在文章front matter中可用的参数
---
title: "文章标题"
date: 2026-01-08T10:30:00+08:00
draft: true
tags: ["标签1", "标签2"]
categories: ["分类"]
summary: "文章摘要"
description: "文章描述（用于SEO）"
keywords: ["关键词1", "关键词2"]

# PaperMod特定参数
showToc: true
tocOpen: true
hidemeta: false  # 隐藏元数据
hideSummary: false  # 隐藏摘要
showReadingTime: true
showComments: true
showShareButtons: true
showBreadCrumbs: true

# 封面图片
cover:
  image: "/path/to/cover.jpg"
  alt: "图片描述"
  caption: "图片说明"
  relative: false  # 是否使用相对路径

# 特色图片（用于列表页）
images:
  - "/path/to/featured.jpg"

# 相关文章配置
related:
  includeNewer: true
  includeOlder: true
  threshold: 80
  toLower: true
---
```

### 项目配置
```yaml
---
title: "项目名称"
date: 2026-01-08
draft: false
project: true  # 标记为项目页面
description: "项目描述"

# 项目链接
links:
  - name: "GitHub"
    url: "https://github.com/username/repo"
    icon: "github"
  - name: "演示"
    url: "https://demo.example.com"
    icon: "external-link"

# 项目技术栈
techstack:
  - "React"
  - "TypeScript"
  - "Node.js"

# 特色项目
featured: true

# 项目状态
status: "完成"  # 完成/进行中/计划中
---
```

## 布局配置

### 自定义布局文件
如需覆盖PaperMod主题布局，将文件复制到`layouts/`目录：

1. **主页布局**: `layouts/_default/home.html`
2. **列表布局**: `layouts/_default/list.html`
3. **单页布局**: `layouts/_default/single.html`
4. **分类布局**: `layouts/_default/terms.html`
5. **部分模板**: `layouts/partials/`

### 自定义样式
```yaml
params:
  # 自定义CSS
  customCSS: ["css/custom.css"]

  # 自定义JS
  customJS: ["js/custom.js"]

  # 字体配置
  font:
    text: "'Roboto', sans-serif"
    code: "'Fira Code', monospace"

  # 颜色主题
  colorTheme: "auto"  # auto/light/dark/自定义
```

## 高级配置

### 多语言支持
```yaml
# 启用多语言
defaultContentLanguage: "zh"
defaultContentLanguageInSubdir: false

languages:
  zh:
    languageName: "中文"
    weight: 1
    params:
      description: "中文网站描述"

  en:
    languageName: "English"
    weight: 2
    params:
      description: "English site description"
```

### 分页配置
```yaml
paginate: 10  # 每页文章数
paginatePath: "page"

# 分类页面分页
taxonomies:
  category: "categories"
  tag: "tags"

pagination:
  pagerSize: 5  # 分页器显示页码数
```

### 性能优化
```yaml
# 构建优化
minify:
  minifyOutput: true

# 缓存配置
caches:
  cachedpartial:
    maxAge: -1
    dir: ":resourceDir/_gen"

# 图片处理
imaging:
  quality: 75
  resampleFilter: "CatmullRom"
  anchor: "Smart"
```

## 故障排除

### 常见问题
1. **主题功能未生效**：检查参数名大小写（PaperMod使用驼峰命名）
2. **图片不显示**：确认路径正确且文件存在于static目录
3. **搜索不工作**：确保启用search并配置正确类型
4. **评论不显示**：检查评论系统配置和网络连接

### 调试建议
```bash
# 启用调试模式查看配置加载
hugo --debug

# 检查主题版本
git -C themes/PaperMod log -1 --oneline

# 验证YAML语法
hugo config
```

## 版本兼容性

- PaperMod v8.x：支持Hugo 0.110+
- 最新功能请参考[PaperMod Wiki](https://github.com/adityatelange/hugo-PaperMod/wiki)