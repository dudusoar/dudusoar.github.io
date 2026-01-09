#!/bin/bash

# Hugo内容创建脚本
# 用法: ./create-content.sh [类型] [标题] [选项]

set -e  # 出错时退出

# 默认参数
CONTENT_TYPE="post"
TITLE=""
SLUG=""
DATE=$(date +%Y-%m-%dT%H:%M:%S%z)
DRAFT=true
TAGS=""
CATEGORIES=""
AUTHOR=""
OUTPUT_DIR="content"
VERBOSE=false
EDIT=false

# 显示帮助信息
show_help() {
    echo "Hugo内容创建脚本"
    echo "用法: $0 [类型] [标题] [选项]"
    echo ""
    echo "类型:"
    echo "  post      博客文章 (默认)"
    echo "  project   项目页面"
    echo "  tutorial  教程页面"
    echo "  page      普通页面"
    echo "  about     关于页面"
    echo ""
    echo "选项:"
    echo "  -s, --slug SLUG          自定义URL slug"
    echo "  -d, --date DATE          发布日期 (默认: 当前时间)"
    echo "  -p, --publish            直接发布 (非草稿)"
    echo "  -t, --tags TAGS          标签 (逗号分隔)"
    echo "  -c, --categories CATS    分类 (逗号分隔)"
    echo "  -a, --author AUTHOR      作者"
    echo "  -o, --output-dir DIR     输出目录 (默认: content)"
    echo "  -e, --edit               创建后编辑文件"
    echo "  -v, --verbose            详细输出"
    echo "  -h, --help               显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 post \"我的新文章\" --tags \"hugo,blog\" --categories \"技术\""
    echo "  $0 project \"我的项目\" --publish --tags \"react,nodejs\""
    echo "  $0 tutorial \"Hugo入门指南\" --output-dir content/tutorials"
}

# 解析参数
if [ $# -eq 0 ]; then
    show_help
    exit 0
fi

# 第一个参数是类型
case "$1" in
    post|project|tutorial|page|about)
        CONTENT_TYPE="$1"
        shift
        ;;
    -h|--help)
        show_help
        exit 0
        ;;
    *)
        # 如果没有指定类型，第一个参数可能是标题
        if [[ "$1" == -* ]]; then
            echo "错误: 缺少内容类型"
            show_help
            exit 1
        fi
        ;;
esac

# 第二个参数是标题
if [ $# -gt 0 ] && [[ "$1" != -* ]]; then
    TITLE="$1"
    shift
fi

# 解析选项
while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--slug)
            SLUG="$2"
            shift 2
            ;;
        -d|--date)
            DATE="$2"
            shift 2
            ;;
        -p|--publish)
            DRAFT=false
            shift
            ;;
        -t|--tags)
            TAGS="$2"
            shift 2
            ;;
        -c|--categories)
            CATEGORIES="$2"
            shift 2
            ;;
        -a|--author)
            AUTHOR="$2"
            shift 2
            ;;
        -o|--output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -e|--edit)
            EDIT=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "未知选项: $1"
            show_help
            exit 1
            ;;
    esac
done

# 检查必要参数
if [ -z "$TITLE" ]; then
    echo "错误: 标题不能为空"
    echo "用法: $0 [类型] \"标题\" [选项]"
    exit 1
fi

# 检查Hugo是否安装
if ! command -v hugo &> /dev/null; then
    echo "错误: Hugo未安装"
    echo "请安装Hugo: https://gohugo.io/installation/"
    exit 1
fi

# 生成slug（如果未提供）
if [ -z "$SLUG" ]; then
    # 转换标题为slug：小写、替换空格为连字符、移除特殊字符
    SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
fi

# 确定文件路径
case "$CONTENT_TYPE" in
    post)
        FILE_PATH="$OUTPUT_DIR/posts/${SLUG}.md"
        KIND="post"
        ;;
    project)
        FILE_PATH="$OUTPUT_DIR/projects/${SLUG}.md"
        KIND="project"
        ;;
    tutorial)
        FILE_PATH="$OUTPUT_DIR/tutorials/${SLUG}.md"
        KIND="tutorial"
        ;;
    page)
        FILE_PATH="$OUTPUT_DIR/pages/${SLUG}.md"
        KIND="page"
        ;;
    about)
        FILE_PATH="$OUTPUT_DIR/about/${SLUG}.md"
        KIND="about"
        ;;
esac

# 确保目录存在
mkdir -p "$(dirname "$FILE_PATH")"

# 显示创建信息
echo "📝 创建新内容..."
echo "📄 类型: $CONTENT_TYPE"
echo "🏷️  标题: $TITLE"
echo "🔗 Slug: $SLUG"
echo "📁 路径: $FILE_PATH"
[ "$DRAFT" = false ] && echo "🚀 状态: 已发布" || echo "📋 状态: 草稿"
[ -n "$TAGS" ] && echo "🏷️  标签: $TAGS"
[ -n "$CATEGORIES" ] && echo "📂 分类: $CATEGORIES"
[ -n "$AUTHOR" ] && echo "👤 作者: $AUTHOR"

# 使用Hugo创建内容
echo "⏳ 使用Hugo创建内容..."

# 构建Hugo命令
HUGO_CMD="hugo new"

# 添加kind参数（如果适用）
if [ -n "$KIND" ] && [ "$KIND" != "post" ]; then
    HUGO_CMD="$HUGO_CMD --kind $KIND"
fi

# 执行Hugo命令
if [ "$VERBOSE" = true ]; then
    echo "执行: $HUGO_CMD \"$FILE_PATH\""
fi

$HUGO_CMD "$FILE_PATH"

# 检查文件是否创建成功
if [ ! -f "$FILE_PATH" ]; then
    echo "❌ 错误: 文件未创建成功"
    echo "尝试手动创建: hugo new \"$FILE_PATH\""
    exit 1
fi

echo "✅ 文件创建成功: $FILE_PATH"

# 更新front matter
echo "✏️  更新front matter..."

# 备份原始文件
cp "$FILE_PATH" "${FILE_PATH}.bak"

# 读取并更新front matter
{
    # 读取第一行（应该是front matter开始）
    head -1 "$FILE_PATH"

    # 更新标题
    echo "title: \"$TITLE\""

    # 更新日期
    echo "date: $DATE"

    # 更新草稿状态
    echo "draft: $DRAFT"

    # 添加标签（如果有）
    if [ -n "$TAGS" ]; then
        # 将逗号分隔的标签转换为YAML数组
        echo "tags:"
        echo "$TAGS" | tr ',' '\n' | while read tag; do
            tag=$(echo "$tag" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            if [ -n "$tag" ]; then
                echo "  - \"$tag\""
            fi
        done
    fi

    # 添加分类（如果有）
    if [ -n "$CATEGORIES" ]; then
        echo "categories:"
        echo "$CATEGORIES" | tr ',' '\n' | while read cat; do
            cat=$(echo "$cat" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            if [ -n "$cat" ]; then
                echo "  - \"$cat\""
            fi
        done
    fi

    # 添加作者（如果有）
    if [ -n "$AUTHOR" ]; then
        echo "author: \"$AUTHOR\""
    fi

    # 根据内容类型添加特定字段
    case "$CONTENT_TYPE" in
        project)
            echo "project: true"
            echo "description: \"$TITLE的描述\""
            echo "featured: false"
            ;;
        tutorial)
            echo "tutorial: true"
            echo "difficulty: beginner"  # beginner/intermediate/advanced
            echo "duration: \"30分钟\""
            ;;
    esac

    # 读取剩余的front matter（跳过已处理的字段）
    sed -n '2,$p' "$FILE_PATH" | while read line; do
        # 跳过已处理的字段
        case "$line" in
            title:*|date:*|draft:*|tags:*|categories:*|author:*|project:*|description:*|featured:*|tutorial:*|difficulty:*|duration:*)
                continue
                ;;
            "---")
                # 遇到front matter结束，停止跳过
                echo "$line"
                break
                ;;
            *)
                echo "$line"
                ;;
        esac
    done

    # 添加正文内容
    echo ""
    echo "# $TITLE"
    echo ""
    case "$CONTENT_TYPE" in
        post)
            echo "在这里开始写你的博客文章..."
            echo ""
            echo "<!--more-->"
            echo ""
            echo "正文内容..."
            ;;
        project)
            echo "## 项目概述"
            echo ""
            echo "项目描述..."
            echo ""
            echo "## 技术栈"
            echo ""
            echo "- 技术1"
            echo "- 技术2"
            echo ""
            echo "## 功能特性"
            echo ""
            echo "- 功能1"
            echo "- 功能2"
            ;;
        tutorial)
            echo "## 教程目标"
            echo ""
            echo "通过学习本教程，你将学会..."
            echo ""
            echo "## 前置要求"
            echo ""
            echo "- 要求1"
            echo "- 要求2"
            echo ""
            echo "## 步骤"
            echo ""
            echo "### 步骤1: 开始"
            echo ""
            echo "详细说明..."
            ;;
        *)
            echo "正文内容..."
            ;;
    esac

} > "${FILE_PATH}.new"

# 替换原始文件
mv "${FILE_PATH}.new" "$FILE_PATH"
rm -f "${FILE_PATH}.bak"

echo "✅ Front matter更新完成"

# 显示文件内容
if [ "$VERBOSE" = true ]; then
    echo ""
    echo "📄 文件内容预览:"
    echo "═══════════════════════════════════════════════════"
    head -30 "$FILE_PATH"
    echo "═══════════════════════════════════════════════════"
fi

# 编辑文件（如果请求）
if [ "$EDIT" = true ]; then
    echo "📝 打开编辑器..."
    if command -v code &> /dev/null; then
        code "$FILE_PATH"
    elif command -v nano &> /dev/null; then
        nano "$FILE_PATH"
    elif command -v vim &> /dev/null; then
        vim "$FILE_PATH"
    else
        echo "⚠️  未找到合适的编辑器，请手动编辑: $FILE_PATH"
    fi
fi

echo ""
echo "🎉 内容创建完成!"
echo "💡 下一步:"
echo "   1. 编辑文件: $FILE_PATH"
echo "   2. 启动开发服务器: hugo server -D"
echo "   3. 访问 http://localhost:1313 预览"
if [ "$DRAFT" = true ]; then
    echo "   4. 发布时设置 draft: false"
fi