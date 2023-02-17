#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================


echo
read -r -n 1 -p "You are running $(python --version), do you want to upgrade to v3.11? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then

    cat << EOF


Updating Apt...

EOF

    # NOTE: The PPA does not support Ubuntu 22.10.
    # You may follow the bottom link to build it from source tarball.
    # sudo add-apt-repository ppa:deadsnakes/ppa

    sudo apt update

    for __bin in "${INSTALL_BINARIES[@]}"
    do

        cat << EOF


Installing ${__bin}...

EOF

        sudo apt install "$__bin"

        if [[ "$__bin" =~ ^python.* ]]
        then
            sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/"$__bin" 100

            pip install --upgrade pip
        fi

        cat << EOF

You are now running $(${__bin//postgresql/psql} --version || :)

EOF

    done

fi
