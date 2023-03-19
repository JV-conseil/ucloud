#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::is_apt_available() {
  if _ucld_::is_ucloud_env && [ -x "$(command -v apt)" ]; then
    true
  else
    false
  fi
}

_ucld_::update_and_upgrade_apt() {
  if ! _ucld_::is_apt_available; then
    return
  fi
  sudo apt clean -y
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y
}

_ucld_::install_apt_packages() {
  local _bin

  if ! _ucld_::is_apt_available; then
    return
  fi

  _ucld_::h2 "Updating Apt"

  # NOTE: The PPA does not support Ubuntu 22.10.
  # You may follow the bottom link to build it from source tarball.
  # sudo add-apt-repository ppa:deadsnakes/ppa

  _ucld_::update_and_upgrade_apt

  for _bin in "${UCLD_INSTALL_PACKAGES[@]}"; do

    if _ucld_::is_debian_running && [[ "${_bin}" == "python"* ]]; then
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
_ucld_::update_python_version() {
  local _main="/work/ucloud" _install="/work/install" _python="3.11.2"

  if [ -n "${UCLD_PATH[install]}" ] &>/dev/null || :; then
    _install="${UCLD_PATH[install]}"
    _main="${UCLD_PATH[main]}"
  fi

  cd "${_install}" || return

  wget "https://www.python.org/ftp/python/${_python}/Python-${_python}.tgz"
  tar -xvf "Python-${_python}.tgz"

  cd "Python-${_python}" || return

  sudo "./configure" --enable-optimizations
  sudo make -j "$(nproc)"
  sudo make altinstall
  sudo pip install --upgrade pip

  cd "${_main}" || return
}

_ucld_::full_update_and_install() {
  local _start _stop

  if ! _ucld_::is_apt_available; then
    return
  fi

  _start=$(date +%s)

  _ucld_::install_apt_packages
  # _ucld_::update_python_version

  _stop=$(date +%s)
  _ucld_::h3 "Install completed in $((_stop - _start)) seconds"
}

_ucld_::ask_update_linux() {
  if _ucld_::is_apt_available; then
    if _ucld_::ask "Do you want to install packages for Linux with apt"; then
      _ucld_::full_update_and_install
    fi
  fi
}
