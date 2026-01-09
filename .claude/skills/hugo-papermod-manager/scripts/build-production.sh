#!/bin/bash

# Hugo生产构建脚本
# 用法: ./build-production.sh [选项]

set -e  # 出错时退出

# 默认参数
OUTPUT_DIR="./public"
ENVIRONMENT="production"
MINIFY=true
CLEAN_BUILD=false
ENABLE_GIT_INFO=false
VERBOSE=false
MEASURE_PERFORMANCE=false

# 解析参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -o|--output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -e|--environment)
            ENVIRONMENT="$2"
            shift 2
            ;;
        -n|--no-minify)
            MINIFY=false
            shift
            ;;
        -c|--clean)
            CLEAN_BUILD=true
            shift
            ;;
        -g|--git-info)
            ENABLE_GIT_INFO=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -p|--performance)
            MEASURE_PERFORMANCE=true
            shift
            ;;
        -h|--help)
            echo "Hugo生产构建脚本"
            echo "用法: $0 [选项]"
            echo ""
            echo "选项:"
            echo "  -o, --output-dir DIR     输出目录 (默认: ./public)"
            echo "  -e, --environment ENV    环境设置 (默认: production)"
            echo "  -n, --no-minify          禁用压缩"
            echo "  -c, --clean              清理构建缓存"
            echo "  -g, --git-info           启用Git信息"
            echo "  -v, --verbose            详细输出"
            echo "  -p, --performance        性能测量"
            echo "  -h, --help               显示此帮助信息"
            exit 0
            ;;
        *)
            echo "未知选项: $1"
            echo "使用 -h 查看帮助"
            exit 1
            ;;
    esac
done

# 检查Hugo是否安装
if ! command -v hugo &> /dev/null; then
    echo "错误: Hugo未安装"
    echo "请安装Hugo: https://gohugo.io/installation/"
    exit 1
fi

# 清理构建缓存
if [ "$CLEAN_BUILD" = true ]; then
    echo "🧹 清理构建缓存..."
    rm -rf "$OUTPUT_DIR" resources _gen .hugo_build.lock 2>/dev/null || true
fi

# 构建命令
CMD="hugo"

# 添加输出目录
CMD="$CMD -d \"$OUTPUT_DIR\""

# 添加环境
CMD="$CMD --environment \"$ENVIRONMENT\""

# 添加压缩选项
if [ "$MINIFY" = true ]; then
    CMD="$CMD --minify"
fi

# 添加Git信息
if [ "$ENABLE_GIT_INFO" = true ]; then
    CMD="$CMD --enableGitInfo"
fi

# 添加详细输出
if [ "$VERBOSE" = true ]; then
    CMD="$CMD --verbose"
fi

# 添加性能测量
if [ "$MEASURE_PERFORMANCE" = true ]; then
    CMD="$CMD --templateMetrics --templateMetricsHints"
fi

# 添加垃圾回收
CMD="$CMD --gc"

# 显示构建信息
echo "🔨 开始生产构建..."
echo "📁 输出目录: $OUTPUT_DIR"
echo "🌍 环境: $ENVIRONMENT"
[ "$MINIFY" = true ] && echo "⚡ 压缩: 启用"
[ "$CLEAN_BUILD" = true ] && echo "🧹 清理: 已完成"
[ "$ENABLE_GIT_INFO" = true ] && echo "📝 Git信息: 启用"
[ "$VERBOSE" = true ] && echo "📊 输出: 详细模式"
[ "$MEASURE_PERFORMANCE" = true ] && echo "⏱️  性能测量: 启用"

# 检查输出目录是否存在
if [ -d "$OUTPUT_DIR" ]; then
    echo "⚠️  输出目录已存在，将覆盖内容"
    rm -rf "$OUTPUT_DIR"
fi

# 执行命令
echo "⏳ 执行: $CMD"
echo "═══════════════════════════════════════════════════"

# 记录开始时间
START_TIME=$(date +%s)

# 运行Hugo
eval $CMD

# 记录结束时间
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

# 构建统计
echo "═══════════════════════════════════════════════════"
echo "✅ 构建完成!"
echo "⏱️  耗时: ${DURATION}秒"
echo "📊 输出目录大小:"
du -sh "$OUTPUT_DIR" 2>/dev/null || echo "无法统计目录大小"

# 显示构建结果
if [ -d "$OUTPUT_DIR" ]; then
    echo ""
    echo "📁 构建结果:"
    find "$OUTPUT_DIR" -maxdepth 2 -type f -name "*.html" | head -5 | while read file; do
        echo "  - $(basename "$file")"
    done

    COUNT=$(find "$OUTPUT_DIR" -name "*.html" | wc -l)
    echo "  ... 共生成 $COUNT 个HTML文件"

    # 显示首页信息
    if [ -f "$OUTPUT_DIR/index.html" ]; then
        echo ""
        echo "🏠 首页已生成: $OUTPUT_DIR/index.html"
        echo "🌐 可通过以下方式预览:"
        echo "   cd \"$OUTPUT_DIR\" && python -m http.server 8000"
        echo "   然后在浏览器中访问: http://localhost:8000"
    fi
else
    echo "❌ 错误: 输出目录未生成"
    exit 1
fi

# 性能建议
if [ "$MEASURE_PERFORMANCE" = true ] && [ "$DURATION" -gt 30 ]; then
    echo ""
    echo "💡 性能优化建议:"
    echo "  - 考虑使用 --ignoreCache 进行增量构建"
    echo "  - 减少图片资源大小"
    echo "  - 禁用不必要的页面类型: --disableKinds [\"taxonomy\",\"term\"]"
    echo "  - 启用并行构建: --parallel 4"
fi