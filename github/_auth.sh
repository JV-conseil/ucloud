#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::gh_login() {
  cat <<EOF


To generate a personal access token go to
https://github.com/settings/tokens

Click on
Generate new token

Note
UCloud + 1 Day

Expiration
Custom... and pick the day next

Select scopes
minimum required scopes are 'repo', 'read:org', 'workflow'.


? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI?
> Paste an authentication token

EOF
  open "https://github.com/settings/tokens" &>/dev/null || :
  gh auth login --hostname "github.com" --git-protocol "https"
}

if _ucld_::is_gh_cli_installed && ! _ucld_::is_gh_auth_login; then

  if _ucld_::ask_2 "Do you want to authenticate to GitHub"; then
    _ucld_::gh_login
    echo
  fi

fi
