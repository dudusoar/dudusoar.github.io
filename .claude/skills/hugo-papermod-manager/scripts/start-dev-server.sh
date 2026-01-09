#!/bin/bash

# Hugo开发服务器启动脚本
# 用法: ./start-dev-server.sh [选项]

set -e  # 出错时退出

# 默认参数
PORT=1313
BIND="127.0.0.1"
ENVIRONMENT="development"
WITH_DRAFTS=false
VERBOSE=false
OPEN_BROWSER=false

# 解析参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--port)
            PORT="$2"
            shift 2
            ;;
        -b|--bind)
            BIND="$2"
            shift 2
            ;;
        -e|--environment)
            ENVIRONMENT="$2"
            shift 2
            ;;
        -d|--with-drafts)
            WITH_DRAFTS=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -o|--open-browser)
            OPEN_BROWSER=true
            shift
            ;;
        -h|--help)
            echo "Hugo开发服务器启动脚本"
            echo "用法: $0 [选项]"
            echo ""
            echo "选项:"
            echo "  -p, --port PORT          指定端口 (默认: 1313)"
            echo "  -b, --bind ADDRESS       绑定地址 (默认: 127.0.0.1)"
            echo "  -e, --environment ENV    环境设置 (默认: development)"
            echo "  -d, --with-drafts        包含草稿内容"
            echo "  -v, --verbose            详细输出"
            echo "  -o, --open-browser       启动后打开浏览器"
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

# 构建命令
CMD="hugo server"

# 添加参数
CMD="$CMD --port $PORT"
CMD="$CMD --bind $BIND"
CMD="$CMD --environment $ENVIRONMENT"

if [ "$WITH_DRAFTS" = true ]; then
    CMD="$CMD -D"
fi

if [ "$VERBOSE" = true ]; then
    CMD="$CMD --verbose"
fi

# 显示启动信息
echo "🚀 启动Hugo开发服务器..."
echo "📡 地址: http://$BIND:$PORT"
echo "🌍 环境: $ENVIRONMENT"
[ "$WITH_DRAFTS" = true ] && echo "📝 模式: 包含草稿"
[ "$VERBOSE" = true ] && echo "📊 输出: 详细模式"

# 执行命令
echo "⏳ 执行: $CMD"
echo "═══════════════════════════════════════════════════"

if [ "$OPEN_BROWSER" = true ]; then
    # 根据操作系统打开浏览器
    case "$(uname -s)" in
        Linux*)     xdg-open "http://$BIND:$PORT" & ;;
        Darwin*)    open "http://$BIND:$PORT" & ;;
        CYGWIN*|MINGW*|MSYS*)
            start "http://$BIND:$PORT" & ;;
        *)          echo "⚠️  无法自动打开浏览器，请手动访问: http://$BIND:$PORT" ;;
    esac
fi

# 运行Hugo
exec $CMD