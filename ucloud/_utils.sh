#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================


#
# MAKE TERMINAL BETTER
#

# alias cp='cp -iv'                         # Preferred 'cp' implementation
alias cp='cp -v'                            # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ls='ls -FGlAhp'                       # Preferred 'ls' implementation
cd_() { builtin cd "$@" || exit ; }         # Silent cd with no list directory
cd() { builtin cd "$@" || exit ; ls ; }     # Always list directory contents upon 'cd'


#
# PRINT ENVIRONMENT VARIABLES
# sorted by name including variables with newlines
# https://stackoverflow.com/a/60756021/2477854
#

cat /proc/version || :
cat /etc/issue || :
bash --version

if [[ "${DEBUG}" == 1 ]]
then
    env -0 | sort -z | tr '\0' '\n'
fi


#
# BACK TO /UCLOUD DIR
#

back_to_script_dir_ () {

    cd_ "${PATH_TO_SCRIPT_DIR}" || exit

}


#
# RUN
#
start () {

    back_to_script_dir_

    # shellcheck disable=SC1091
    . run.sh

}


#
# PARENT DIR
# https://stackoverflow.com/a/24112741/2477854
#
parent_directory () {
    echo "$(cd_ "$(dirname "${BASH_SOURCE[0]}")" || exit ; pwd -P)"
}
