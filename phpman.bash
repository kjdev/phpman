# phpman function for bash

export PHPMANPATH=${HOME}/.phpman

function phpman() {
    if [ ! "$1" = "" -a -d ${PHPMANPATH}/man/ja ]; then
        man -M ${PHPMANPATH}/man/ja $1
    fi
}

function _phpman() {
    local keys word

    if [ ! -r ${PHPMANPATH}/index ]; then
        return 1
    fi

    word=${COMP_WORDS[COMP_CWORD]}

    if [ ! "$word" = "" ]; then
        keys=$(grep "^$word" ${PHPMANPATH}/index | cut -d '[' -f 1 | sed -e 's/::/\\:\\:/')
    else
        keys=$(cat ${PHPMANPATH}/index | cut -d '[' -f 1  | sed -e 's/:/\\:/g')
    fi

    if [ ${#keys[*]} -gt 0 ]; then
        COMPREPLY=($(compgen -W "${keys[@]}" $word))
    fi

    return 0
}

complete -F _phpman phpman
