
function set_proxy
    set -g http_proxy "$PROXY"
    set -g https_proxy "$PROXY"
    set -g ftp_proxy "$PROXY"
    set -g no_proxy '127.0.0.1,localhost,host.docker.internal'

    set -g HTTP_PROXY "$PROXY"
    set -g HTTPS_PROXY "$PROXY"
    set -g FTP_PROXY "$PROXY"
    set -g NO_PROXY '127.0.0.1,localhost,host.docker.internal'
end

function unset_proxy
    set -e http_proxy
    set -e https_proxy
    set -e ftp_proxy
    set -e no_proxy

    set -e HTTP_PROXY
    set -e HTTPS_PROXY
    set -e FTP_PROXY
    set -e NO_PROXY
end

if test -n "$PROXY"
    set_proxy
else
    unset_proxy
end