#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# List organizations for the authenticated user
# <https://docs.github.com/en/rest/orgs/orgs?apiVersion=2022-11-28#list-organizations-for-the-authenticated-user>
#
#====================================================

_ucld_::gh_list_user_orgs() {
  gh api -H "Accept: application/vnd.github+json" /user/orgs --jq '.[].login' 2>>logfile.log
}

_ucld_::gh_list_user_repos() {
  local _choice _owners _repo _org
  declare -a _owners=("")

  _choice=${1:-""}
  # shellcheck disable=SC2207
  _owners+=($(_ucld_::gh_list_user_orgs || :))

  for _org in "${_owners[@]}"; do

    if [ "${_choice}" == "full" ]; then

      gh repo list "${_org}" --no-archived

    else

      for _repo in $(gh repo list "${_org}" --no-archived --json nameWithOwner --jq '.[].nameWithOwner'); do
        if [[ ${_repo} =~ ^.*\/(\.).*$ ]]; then
          continue
        fi
        echo "${_repo}"
      done

    fi

  done

}

_ucld_::is_gh_cli_installed() {
  local _bool=false
  if [ -x "$(command -v gh)" ]; then _bool=true; fi
  echo ${_bool}
}

_ucld_::is_gh_auth_login() {
  local _bool=false
  if gh auth status &>/dev/null; then _bool=true; fi
  echo ${_bool}
}
