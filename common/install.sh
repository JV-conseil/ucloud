#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# export INSTALL_PACKAGES=("bash" "python3.11" "postgresql" "postgresql-contrib")
export INSTALL_PACKAGES=("bash" "git" "nano" "python3.11")

_ucld_::install() {
  cat <<EOF


========================================
 Installing packages for Linux with apt
========================================


Updating Apt...

EOF

  # NOTE: The PPA does not support Ubuntu 22.10.
  # You may follow the bottom link to build it from source tarball.
  # sudo add-apt-repository ppa:deadsnakes/ppa

  sudo apt update && sudo apt upgrade

  for _bin in "${INSTALL_PACKAGES[@]}"; do

    cat <<EOF


Installing ${_bin}...

EOF

    sudo apt install --only-upgrade -y "$_bin"

    if [[ "$_bin" =~ ^python.* ]]; then
      sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/"$_bin" 100

      pip install --upgrade pip
    fi

    cat <<EOF

You are now running $(${_bin//postgresql/psql} --version || :)

EOF
  done
}

alias install="_ucld_::install"
