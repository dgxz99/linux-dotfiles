if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting ""
# set -p PATH ~/.local/bin

# starship 
starship init fish | source
# zoxide 路径导航工具，提供更智能的 cd 命令
zoxide init fish --cmd cd | source

# fa运行fastfetch
abbr fa fastfetch

# 终端增强：使用 eza 替代 ls，提供更丰富的输出格式和图标支持
alias ls='eza --icons'
alias ll='eza -la --icons'
alias lt="eza --icons --tree --level=3"

# yazi 快捷打开
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# 随机动漫壁纸脚本 (API 下载)
function graw
    command ~/.local/bin/gnome-random-anime-wallpaper $argv
end

# 随机本地壁纸脚本
function raw
    command ~/.local/bin/gnome-random-wallpaper $argv
end

# sl 命令的彩色版本，使用 lolcat 增强输出效果
function sl
    command sl | lolcat
end

# 代理
proxy-on
