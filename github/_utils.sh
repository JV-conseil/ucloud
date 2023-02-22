#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# List organizations for the authenticated user
# <https://docs.github.com/en/rest/orgs/orgs?apiVersion=2022-11-28#list-organizations-for-the-authenticated-user>
#
# shellcheck disable=SC2207
#
#====================================================

_ucld_::gh_list_user_orgs() {
  gh api -H "Accept: application/vnd.github+json" /user/orgs --jq '.[].login'
}

_ucld_::gh_list_user_repos() {
  local _choice _owners _repos
  declare -a _repos
  declare -a _owners=("")

  _choice=${1}
  _owners+=($(_ucld_::gh_list_user_orgs)) || return

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

_ucld_::gh_is_cli_installed() {
  if [ -x "$(command -v gh)" ]; then echo true; else echo false; fi
}

_ucld_::gh_is_authenticated() {
  if gh auth status &>>logfile.log; then echo true; else echo false; fi
}
