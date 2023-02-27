#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::gh_login() {
  cat <<EOF


Authenticating to GitHub with a Personal Access Token...

- generate one token here https://github.com/settings/tokens
- minimum required scopes are 'repo', 'read:org', 'workflow'.
- expiration Custom... + 1 day.

? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI?
> Paste an authentication token

EOF

  gh auth login --hostname "github.com" --git-protocol "https"
}

if [[ "$(_ucld_::is_gh_cli_installed)" == true && "$(_ucld_::is_gh_auth_login)" == false ]]; then

  if "$(_ucld_::ask_2 "Do you want to authenticate to GitHub")"; then
    _ucld_::gh_login
  fi

fi
