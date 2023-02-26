#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::gh_clone() {
  # gh repo list JV-conseil --visibility public
  #   cat <<EOF

  # Clone GitHub repo
  # -----------------
  # EOF

  _ucld_::h2 "Clone GitHub repo"

  # gh repo list
  _ucld_::gh_list_user_repos full

  #   cat <<EOF

  # Choose one of the repo in the list below to clone it into ${UCLD_PATH[work]}

  # EOF

  _ucld_::h2 "Choose one of the repo in the list below to clone it into ${UCLD_PATH[work]}"

  # select _gh_repo in $(gh repo list --json nameWithOwner --jq '.[].nameWithOwner'); do
  select _gh_repo in $(_ucld_::gh_list_user_repos); do
    test -n "${_gh_repo}" && break
    echo ">>> Invalid Selection"
  done

  if [[ "${_gh_repo}" ]]; then

    #     cat <<EOF

    # Cloning ${_gh_repo} into ${UCLD_PATH[work]}...

    # EOF

    _ucld_::h2 "Cloning ${_gh_repo} into ${UCLD_PATH[work]}"

    if [[ -d "${UCLD_PATH[work]}/${_gh_repo#*/}" ]]; then
      _ucld_::h2 "${_gh_repo#*/} is already cloned" "magenta"
      ls "${UCLD_PATH[work]}/${_gh_repo#*/}"

    else

      cd_ "${UCLD_PATH[work]}"
      gh repo clone "${_gh_repo}" &>>"${UCLD_PATH[main]}/logfile.log"
      _ucld_::back_to_script_dir_
      ls "${UCLD_PATH[work]}"

    fi

  fi
}

if [[ "$(_ucld_::is_gh_cli_installed)" == true && "$(_ucld_::is_gh_auth_login)" == true ]]; then

  # echo
  # read -r -n 1 -p "Do you want to clone one of your repo? [y/N] "
  # if [[ $REPLY =~ ^[Yy]$ ]]; then

  if "$(_ucld_::ask_2 "Do you want to clone one of your repo")"; then
    _ucld_::gh_clone
  fi
fi
