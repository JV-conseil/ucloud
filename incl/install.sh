#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

if [[ $(apt -v &>>logfile.log) -eq 0 ]]; then

  cat <<EOF


Installing packages for Linux with apt
--------------------------------------


Updating Apt...

EOF

  # NOTE: The PPA does not support Ubuntu 22.10.
  # You may follow the bottom link to build it from source tarball.
  # sudo add-apt-repository ppa:deadsnakes/ppa

  sudo apt update && sudo apt upgrade

  for _bin in "${INSTALL_LINUX_PACKAGES[@]}"; do

    cat <<EOF


Installing ${_bin}...

EOF

    # sudo apt install --only-upgrade -y "$_bin"
    sudo apt install --only-upgrade -y "python3.11" || sudo apt install -y "python3.11"

    if [[ "$_bin" =~ ^python.* ]]; then
      sudo apt install -y "$_bin"
      # sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.11 1
      # sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/"${_bin}" 100
      sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/"${_bin}" 1

      pip install --upgrade pip
    else
      sudo apt install --only-upgrade -y "$_bin"
    fi

    cat <<EOF

You are now running $(${_bin%.*} --version 2>>logfile.log)

EOF
  done

fi
