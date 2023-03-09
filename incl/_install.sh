#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# license       : EUPL-1.2 license
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::is_apt_available() {
  local _bool=false
  if "$(_ucld_::is_ucloud_env)" && [ -x "$(command -v apt)" ]; then _bool=true; fi
  echo "${_bool}"
}

_ucld_::update_and_upgrade_apt() {
  if ! "$(_ucld_::is_apt_available)"; then
    return
  fi
  sudo apt clean -y
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y
}

_ucld_::install_apt_packages() {
  local _bin

  if ! "$(_ucld_::is_apt_available)"; then
    return
  fi

  _ucld_::h2 "Updating Apt"

  # NOTE: The PPA does not support Ubuntu 22.10.
  # You may follow the bottom link to build it from source tarball.
  # sudo add-apt-repository ppa:deadsnakes/ppa

  _ucld_::update_and_upgrade_apt

  for _bin in "${UCLD_INSTALL_PACKAGES[@]}"; do

    if "$(_ucld_::is_debian_running)" && [[ "${_bin}" == "python"* ]]; then
      continue
    fi

    _ucld_::h2 "Installing ${_bin}"

    sudo apt install -y "$_bin" || :

    if [[ "$_bin" =~ ^python.* ]]; then
      # sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.11 1
      # sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/"${_bin}" 100
      sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/"${_bin}" 100

      pip install --upgrade pip
    fi

    _ucld_::h3 "You are now running $(${_bin%.*} --version 2>>logfile.log)"
  done

  echo
}

# Install Python3 from source
# <https://cloudinfrastructureservices.co.uk/how-to-install-python-3-in-debian-11-10/>
# <https://computingforgeeks.com/how-to-install-python-on-debian-linux/>
# <https://computingforgeeks.com/how-to-install-python-on-ubuntu-linux/>
_ucld_::udpate_python_version() {
  local _path="/work/install" _python="3.11.2"
  # sudo apt update -y && sudo apt upgrade -y
  # sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
  # sudo apt install -y python3
  cd "${_path}" || cd "${UCLD_PATH[install]}" || return
  wget "https://www.python.org/ftp/python/${_python}/Python-${_python}.tgz"
  tar -xvf "Python-${_python}.tgz"
  cd "Python-${_python}" || return 0
  sudo "./configure" --enable-optimizations
  sudo make -j "$(nproc)"
  sudo make altinstall
  sudo pip install --upgrade pip
  cd "${_path%/*}" || return
}

_ucld_::full_update_and_install() {
  local _start _stop

  if ! "$(_ucld_::is_apt_available)"; then
    return
  fi

  _start=$(date +%s)

  _ucld_::install_apt_packages
  _ucld_::udpate_python_version

  _stop=$(date +%s)
  _ucld_::h3 "Install completed in $((_stop - _start)) seconds"
}

_ucld_::ask_update_linux() {
  if "$(_ucld_::is_apt_available)"; then
    if "$(_ucld_::ask "Do you want to install packages for Linux with apt")"; then
      _ucld_::full_update_and_install
    fi
  fi
}
