#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================


ERASE_APP=("${UCLOUD_APP_DIR}" "${UCLOUD_INSTALL_DIR}")


erase_app () {
    echo
    read -r -n 1 -p "Are you sure? [y/N] "
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        for __dir in "${ERASE_APP[@]}"
        do

            rm -rf "${__dir}" || :

        done
    fi
}


echo
read -r -n 1 -p "Do you want to remove the app? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then

    erase_app

    gh auth logout

    back_to_script_dir_

fi
