# Hugo命令参考

## 基本命令

### 服务器命令
```bash
# 启动开发服务器（默认端口1313）
hugo server

# 使用草稿模式启动
hugo server -D

# 绑定到指定端口
hugo server -p 8080

# 绑定到指定网络接口
hugo server --bind 0.0.0.0

# 使用生产环境配置
hugo server --environment production

# 启用详细输出
hugo server --verbose

# 禁用实时重载
hugo server --disableLiveReload

# 启用Fast Render模式（跳过渲染某些文件）
hugo server --renderToDisk
```

### 构建命令
```bash
# 基本构建（输出到public目录）
hugo

# 构建并压缩（生产部署）
hugo --minify

# 构建指定环境
hugo --environment staging

# 构建草稿内容
hugo -D

# 构建过期内容
hugo -E

# 构建未来内容
hugo -F

# 构建所有内容（包括草稿、过期、未来）
hugo --buildDrafts --buildExpired --buildFuture

# 构建到指定目录
hugo -d ./dist

# 清理构建缓存
hugo --gc
```

### 内容管理
```bash
# 创建新内容
hugo new posts/my-article.md

# 使用特定archetype模板
hugo new posts/my-post.md --kind post

# 创建新章节
hugo new blog/_index.md

# 批量创建内容
hugo new posts/2026/01/my-post.md

# 从现有文件创建
hugo new --source ./path/to/template.md posts/my-post.md
```

## 内容操作命令

### 内容列表
```bash
# 列出所有内容
hugo list all

# 列出草稿内容
hugo list drafts

# 列出过期内容
hugo list expired

# 列出未来内容
hugo list future

# 列出指定日期的内容
hugo list future --date "2026-01-01"

# 以JSON格式输出
hugo list all --format json

# 包含完整路径
hugo list all --path
```

### 内容处理
```bash
# 导入Jekyll内容
hugo import jekyll /path/to/jekyll/content

# 导入WordPress内容
hugo import wp /path/to/wordpress/export.xml

# 重新生成资源（图片、CSS等）
hugo --renderSegments

# 处理缺失的翻译
hugo --printMissingTranslations
```

## 配置和调试命令

### 配置管理
```bash
# 显示当前配置
hugo config

# 显示指定配置项
hugo config | grep baseURL

# 显示所有设置
hugo config --all

# 以JSON格式显示配置
hugo config --format json

# 验证配置语法
hugo config --verbose

# 显示模块信息
hugo config mounts
```

### 调试命令
```bash
# 启用调试模式
hugo --debug

# 启用详细输出
hugo --verbose

# 显示构建时间统计
hugo --templateMetrics

# 显示构建时间直方图
hugo --templateMetricsHints

# 显示内存使用情况
hugo --printMemoryUsage

# 显示未使用的模板
hugo --printUnusedTemplates

# 显示I18n警告
hugo --printI18nWarnings

# 显示路径解析
hugo --printPathWarnings
```

## 模块和依赖管理

### 模块命令
```bash
# 初始化模块
hugo mod init github.com/username/repo

# 获取模块依赖
hugo mod get

# 清理模块缓存
hugo mod clean

# 更新模块
hugo mod get -u

# 更新指定模块
hugo mod get -u github.com/adityatelange/hugo-PaperMod

# 显示模块图
hugo mod graph

# 显示模块供应商
hugo mod vendor

# 验证模块
hugo mod verify
```

### 主题管理
```bash
# 添加主题模块
hugo mod init
hugo mod get github.com/adityatelange/hugo-PaperMod

# 更新主题
hugo mod get -u github.com/adityatelange/hugo-PaperMod

# 使用特定版本
hugo mod get github.com/adityatelange/hugo-PaperMod@v8.0.0

# 降级主题版本
hugo mod get github.com/adityatelange/hugo-PaperMod@v7.0.0
```

## 部署相关命令

### 构建优化
```bash
# 构建并启用Gzip压缩
hugo --minify --enableGitInfo

# 构建Sitemap
hugo --enableRobotsTXT

# 构建搜索索引
hugo --enableSearchIndex

# 禁用某些功能以提高构建速度
hugo --disableKinds ["taxonomy", "term"]

# 并行构建
hugo --parallel 4
```

### 输出控制
```bash
# 构建到不同基础URL
hugo --baseURL "https://staging.example.com/"

# 强制重新构建所有页面
hugo --force

# 跳过渲染特定内容类型
hugo --disableKinds "RSS"

# 仅构建特定内容类型
hugo --buildFuture --buildExpired --kind "page"

# 构建并同步到指定目录
hugo && rsync -avz public/ user@server:/var/www/html/
```

## 实用工具命令

### 静态文件管理
```bash
# 处理静态文件
hugo --source ./static --destination ./public

# 复制静态资源
hugo --source ./assets --destination ./static

# 处理图片资源
hugo --source ./images --destination ./static/images
```

### 开发工具
```bash
# 生成新网站
hugo new site my-new-site

# 显示帮助
hugo help

# 显示版本信息
hugo version

# 检查环境
hugo env

# 显示环境变量
hugo env -v

# 显示构建信息
hugo env --logLevel info
```

## Git集成命令

### 与Git工作流结合
```bash
# 构建并提交
hugo && cd public && git add . && git commit -m "更新网站"

# 构建并推送
hugo && cd public && git add . && git commit -m "更新" && git push

# 使用Git信息构建
hugo --enableGitInfo

# 显示Git构建信息
hugo config | grep gitInfo
```

## 性能优化命令

### 构建性能
```bash
# 限制并发构建
hugo --parallel 2

# 禁用某些耗时的功能
hugo --disableLiveReload --disableFastRender

# 缓存构建结果
hugo --cacheDir ./cache

# 清理缓存
rm -rf resources _gen

# 增量构建（仅修改的文件）
hugo --ignoreCache
```

### 内存优化
```bash
# 限制内存使用
hugo --printMemoryUsage --verbose

# 禁用某些内存密集型功能
hugo --disableKinds ["home", "section"]

# 分批处理大型站点
hugo --buildLimit 100
```

## 故障排除命令

### 诊断问题
```bash
# 检查配置问题
hugo config --verbose 2>&1 | grep -i error

# 检查主题兼容性
hugo version && git -C themes/PaperMod log -1

# 检查内容文件语法
hugo --buildDrafts --verbose 2>&1 | grep -A5 -B5 "error"

# 检查模板错误
hugo --templateMetrics --templateMetricsHints

# 检查资源处理
hugo --renderSegments --verbose
```

### 修复常见问题
```bash
# 重置构建状态
rm -rf public resources _gen .hugo_build.lock

# 重新初始化模块
hugo mod clean && hugo mod get

# 修复权限问题
chmod -R 755 ./static

# 修复符号链接
find . -type l -exec rm {} \; && hugo mod get
```

## 环境变量

Hugo支持以下环境变量：
```bash
# 设置环境
HUGO_ENVIRONMENT=production hugo

# 设置基础URL
HUGO_BASEURL="https://example.com" hugo

# 设置主题
HUGO_THEME="PaperMod" hugo

# 设置构建目录
HUGO_DESTINATION="./dist" hugo

# 启用详细日志
HUGO_LOG_LEVEL="debug" hugo server
```

## 命令组合示例

### 开发工作流
```bash
# 启动开发服务器并打开浏览器
hugo server -D && start http://localhost:1313

# 监控更改并自动构建
hugo server --watch --disableFastRender

# 开发时启用所有功能
hugo server -DEF --verbose --disableLiveReload
```

### 生产构建工作流
```bash
# 完整生产构建
hugo --minify --enableGitInfo --enableRobotsTXT --environment production

# 带清理的构建
rm -rf public && hugo --minify --gc

# 构建并部署
hugo --minify && scp -r public/* user@server:/var/www/html/
```

### 内容管理工作流
```bash
# 创建并编辑新文章
hugo new posts/$(date +%Y-%m-%d)-my-article.md
code content/posts/$(date +%Y-%m-%d)-my-article.md

# 发布草稿
find content -name "*.md" -exec sed -i 's/draft: true/draft: false/g' {} \;

# 批量更新日期
find content/posts -name "*.md" -exec sed -i "s/date:.*/date: $(date +%Y-%m-%dT%H:%M:%S%z)/" {} \;
```

记住：使用`hugo help <command>`查看特定命令的详细帮助信息。