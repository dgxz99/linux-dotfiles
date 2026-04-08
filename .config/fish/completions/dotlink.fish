complete -c dotlink -f
complete -c dotlink -n '__fish_use_subcommand' -a link -d '建立或更新软链接'
complete -c dotlink -n '__fish_use_subcommand' -a unlink -d '移除通过此脚本创建的软链接'
complete -c dotlink -s h -l help -d '显示帮助信息'
complete -c dotlink -l dry-run -d '预览模式，只显示将要执行的操作'
