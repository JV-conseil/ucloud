#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_ucld_::gh_cli_install() {
  local gh_cli_version gh_cli_archive
  gh_cli_version=$(curl --silent "https://api.github.com/repos/cli/cli/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c2-)
  gh_cli_archive="gh_${gh_cli_version}_linux_amd64.tar.gz"

  cat <<EOF


Installing GitHub CLI v$gh_cli_version...

GitHub CLI, or gh, is a command-line interface to GitHub for use in your terminal or your scripts.
https://cli.github.com/manual/

EOF

  if ! [ -x "$(command -v gh)" ]; then

    mkdir -pv "${PATH_TO_INSTALL_DIR}"

    curl -sSL "https://github.com/cli/cli/releases/download/v${gh_cli_version}/${gh_cli_archive}" -o "${PATH_TO_INSTALL_DIR}/${gh_cli_archive}"
    tar -xvf "${PATH_TO_INSTALL_DIR}/${gh_cli_archive}" --directory="${PATH_TO_INSTALL_DIR}"
    sudo cp "${PATH_TO_INSTALL_DIR}/gh_${gh_cli_version}_linux_amd64/bin/gh" /usr/local/bin/
    sudo cp -r "${PATH_TO_INSTALL_DIR}/gh_${gh_cli_version}_linux_amd64/share/man/man1/"* /usr/share/man/man1/

    ls "${PATH_TO_INSTALL_DIR}"

  fi

  cat <<EOF

You are now running $(gh version)

EOF
}

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

  gh version
  gh auth login --hostname "gitHub.com" --git-protocol "https"
}

_ucld_::git_clone() {
  # gh repo list JV-conseil --visibility public
  cat <<EOF


Clone GitHub repo
-----------------
EOF

  # gh repo list
  _ucld_::gh_cli_list_user_repos full

  cat <<EOF

Choose one of the repo in the list below to clone it into ${PATH_TO_WORK_DIR}

EOF

  # select _gh_repo in $(gh repo list --json nameWithOwner --jq '.[].nameWithOwner'); do
  select _gh_repo in $(_ucld_::gh_cli_list_user_repos); do
    test -n "${_gh_repo}" && break
    echo ">>> Invalid Selection"
  done

  if [[ "${_gh_repo}" ]]; then
    cat <<EOF

Cloning ${_gh_repo} into ${PATH_TO_WORK_DIR}...

EOF

    if [[ -d "${PATH_TO_WORK_DIR}/${_gh_repo#*/}" ]]; then
      cat <<EOF

${PATH_TO_WORK_DIR}/${_gh_repo#*/} is already cloned!

EOF
    else
      cd_ "${PATH_TO_WORK_DIR}"
      gh repo clone "${_gh_repo}" &>>"${PATH_TO_SCRIPT_DIR}/logfile.log"
      _ucld_::back_to_script_dir_
      ls "${PATH_TO_WORK_DIR}"
    fi

  fi
}

alias gh_cli_install="_ucld_::gh_cli_install"
