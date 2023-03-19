#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::gh_clone() {
  local _gh_repo=""

  # gh repo list
  _ucld_::gh_list_user_repos "full"

  _ucld_::h2 "Choose one of the repo in the list below to clone it into ${UCLD_PATH[work]}"

  select _gh_repo in $(_ucld_::gh_list_user_repos); do
    test -n "${_gh_repo}" && break
    # echo ">>> Invalid Selection"
    _ucld_::alert ">>> Invalid Selection"
  done

  if [[ "${_gh_repo}" ]]; then

    _ucld_::h2 "Cloning ${_gh_repo} into ${UCLD_PATH[work]}"

    if [[ -d "${UCLD_PATH[work]}/${_gh_repo#*/}" ]]; then
      _ucld_::alert "${_gh_repo#*/} is already cloned"
      ls "${UCLD_PATH[work]}/${_gh_repo#*/}"

    else

      cd_ "${UCLD_PATH[work]}"
      gh repo clone "${_gh_repo}" # &>>"${UCLD_PATH[main]}/logfile.log"
      _ucld_::back_to_script_dir_
      ls "${UCLD_PATH[work]}"

    fi

  fi
}

if _ucld_::is_gh_cli_installed && _ucld_::is_gh_auth_login; then

  if _ucld_::ask_2 "Do you want to clone one of your repo"; then
    _ucld_::gh_clone
    echo
  fi

fi
