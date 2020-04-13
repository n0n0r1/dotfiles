#!/bin/bash

set -eu

PWD=$(cd $(dirname $0); pwd)
DOTFILES_PATH=$(dirname $PWD)
DOTENV=$DOTFILES_PATH/.env

export $(grep -v '^#' $DOTENV | xargs)

sp="/-\|"
sc=0

header() {
    printf "\033[37;1m%s\033[m \n" "$*"
}

item() {
    printf "  \033[37;1m%s\033[m%s \n" "- " "$*"
}

start() {
    printf "  \033[37;1m%s\033[m%s ... %s \r" "- " "$*" "${sp:sc++%${#sp}:1}"
}

success() {
    printf "  \033[37;1m%s\033[m%s ... \033[32mOK\033[m \n" "✔ " "$*"
}

error() {
    printf "  \033[37;1m%s\033[m%s ... \033[31mNG\033[m \n" "✖ " "$*" 1>&2
}

error_message() {
    printf "\033[31m%s\033[m \n" "$*" 1>&2
}

dotfiles() {
    find $DOTFILES_PATH -name ".*" | xargs -I {} find {} -type f | sed -e "s|$DOTFILES_PATH/||g" | grep -v "^\(\.gitignore\|\.git\|.DS_Store\|.env\)"
}

exec_cmd() {
    (
        export $(grep -v '\(^#\|CMD\)' $DOTENV | xargs); $EXEC_CMD $EXEC_OPTS $1
    ) || {
        error $EXEC_CMD $EXEC_OPTS $1
        exit 1
    }
    success $EXEC_CMD $EXEC_OPTS $1
}

symlink_cmd() {
    (
        export $(grep -v '\(^#\|CMD\)' $DOTENV | xargs); $SYMLINK_CMD $SYMLINK_OPTS $1 $2
    ) || {
        error $SYMLINK_CMD $SYMLINK_OPTS $1 $2
        exit 1
    }
    success $SYMLINK_CMD $SYMLINK_OPTS $1 $2
}

initialize() {
    header "Start initializing dotfiles ..."
    TARGET=${1:-}
    if [ ! "$TARGET" == "" -a -e "$DOTFILES_PATH/etc/init/$TARGET.sh" ]; then
        f=$DOTFILES_PATH/etc/init/$TARGET.sh
        exec_cmd $f
    else
        exec_cmd $DOTFILES_PATH/etc/init/base.sh
        for f in $DOTFILES_PATH/etc/init/*.sh
        do
            [ "$(basename $f)" == "base.sh" ] && continue

            exec_cmd $f
        done
    fi
}

list() {
    header "list:"
    header "  init scripts:"
    for f in $DOTFILES_PATH/etc/init/*.sh
    do
        item $(basename --suffix=.sh $f)
    done
    header "  dotfiles:"
    for f in $(dotfiles)
    do
        item "$f"
    done
}

deploy() {
    header "Start deploying dotfiles ..."
    for f in $(dotfiles)
    do
        symlink_cmd "$DOTFILES_PATH/$f" "$HOME/$f"
    done
}

if [ "$1" = "deploy" -o "$1" = "d" ]; then
    deploy
elif [ "$1" = "init" -o "$1" = "i" ]; then
    TARGET=${2:-}
    initialize $TARGET
elif [ "$1" = "list" -o "$1" = "l" ]; then
    list
elif [ "$1" = "test" -o "$1" = "t" ]; then
    TARGET=${2:-}
    EXEC_CMD="echo $EXEC_CMD"
    SYMLINK_CMD="echo $SYMLINK_CMD"
    deploy
    initialize $TARGET
fi