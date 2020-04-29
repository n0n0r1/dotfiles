
function set_proxy
    set proxy ''

    set -x http_proxy "http://$proxy"
    set -x https_proxy "http://$proxy"
    set -x ftp_proxy "http://$proxy"
    set -x no_proxy '127.0.0.1,localhost,host.docker.internal'

    set -x HTTP_PROXY "http://$proxy"
    set -x HTTPS_PROXY "http://$proxy"
    set -x FTP_PROXY "http://$proxy"
    set -x NO_PROXY '127.0.0.1,localhost,host.docker.internal'
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
