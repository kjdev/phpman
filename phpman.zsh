# phpman function for zsh

autoload -U compinit
compinit -u

export PHPMANPATH=${HOME}/.phpman

function phpman() {
    if [ ! "$1" = "" -a -d ${PHPMANPATH}/man/ja ]; then
        man -M ${PHPMANPATH}/man/ja $1
    fi
}

function _phpman() {
    local keys
    local -a args

    if [ ! -r ${PHPMANPATH}/index ]; then
        return 1
    fi

    if [ ! "$words[0]" = "" ]; then
        keys=$(grep "^$words[0]" ${PHPMANPATH}/index | sed -e 's/::/\\:\\:/')
    else
        keys=$(cat ${PHPMANPATH}/index | sed -e 's/:/\\:/g')
    fi

    if [ ${#keys[*]} -gt 0 ]; then
        args=(${(f)keys})
        _values 'PHP Function' "${args[@]}"
    fi

    return 0
}

compdef _phpman phpman
