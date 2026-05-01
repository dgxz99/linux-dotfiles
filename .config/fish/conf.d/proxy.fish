function proxy-on
    set -l mode (gsettings get org.gnome.system.proxy mode | string trim --chars="'")

    if test "$mode" = none
        set -e http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY no_proxy NO_PROXY
        return
    end

    if test "$mode" = manual
        set -l http_host (gsettings get org.gnome.system.proxy.http host | string trim --chars="'")
        set -l http_port (gsettings get org.gnome.system.proxy.http port)

        set -l https_host (gsettings get org.gnome.system.proxy.https host | string trim --chars="'")
        set -l https_port (gsettings get org.gnome.system.proxy.https port)

        set -l ignore_hosts (gsettings get org.gnome.system.proxy ignore-hosts)

        if test -n "$http_host"; and test "$http_port" != 0
            set -gx http_proxy "http://$http_host:$http_port"
            set -gx HTTP_PROXY "$http_proxy"
        end

        if test -n "$https_host"; and test "$https_port" != 0
            set -gx https_proxy "http://$https_host:$https_port"
            set -gx HTTPS_PROXY "$https_proxy"
        else if set -q http_proxy
            set -gx https_proxy "$http_proxy"
            set -gx HTTPS_PROXY "$http_proxy"
        end

        set -gx no_proxy (string replace -a "'" "" -- $ignore_hosts | string replace -a "[" "" | string replace -a "]" "" | string replace -a ", " ",")
        set -gx NO_PROXY "$no_proxy"

        return
    end

    if test "$mode" = auto
        return
    end
end

function proxy-off
    set -e http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY no_proxy NO_PROXY
    proxy-status
end

function proxy-status
    set -l proxy_vars http_proxy https_proxy all_proxy no_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY NO_PROXY
    set -l has_proxy 0

    for name in $proxy_vars
        if set -q $name
            set -l value (eval echo \$$name)
            echo "$name = $value"
            set has_proxy 1
        end
    end

    if test $has_proxy -eq 0
        echo "No proxy environment variables set."
    end
end
