#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================


delete () {
    echo
    read -r -n 1 -p "All files and folder except 'data' & 'ucloud' will be deleted, do you confirm? [y/N] "
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        cd "${PATH_TO_WORK_DIR}" || exit

        find . -not -path "*ucloud*" -and -not -path "*data*" -exec rm -rf {} +

        back_to_script_dir_
    fi
}


echo
read -r -n 1 -p "Do you want to delete imported files? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then

    delete

    gh auth logout

    back_to_script_dir_

fi
