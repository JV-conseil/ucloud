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

    mkdir -p "${PATH_TO_INSTALL_DIR}"

    curl -sSL "https://github.com/cli/cli/releases/download/v${gh_cli_version}/${gh_cli_archive}" -o "${PATH_TO_INSTALL_DIR}/${gh_cli_archive}"
    tar xvf "${PATH_TO_INSTALL_DIR}/${gh_cli_archive}"
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

- generate a Personal Access Token here https://github.com/settings/tokens
- minimum required scopes are 'repo', 'read:org', 'workflow'.
- expiration Custom... the next day.


? What account do you want to log into?
> GitHub.com
? What is your preferred protocol for Git operations?
> HTTPS
? How would you like to authenticate GitHub CLI?
> Paste an authentication token

EOF

  gh version
  gh auth login
}

_ucld_::git_clone() {
  # gh repo list JV-conseil --visibility public

  cat <<EOF


Clone GitHub repo
-----------------

Choose one of the repo listed above to clone it as such

EOF

  gh repo list

  select _gh_repo in $(gh repo list --json nameWithOwner --jq '.[].nameWithOwner'); do
    test -n "${_gh_repo}" && break
    echo ">>> Invalid Selection"
  done

  if [[ -f "${_gh_repo}" ]]; then
    cat <<EOF


Cloning ${_gh_repo} into ${PATH_TO_WORK_DIR}...

EOF
    gh repo clone "${_gh_repo}" "${PATH_TO_WORK_DIR}"
  fi
}

alias gh_cli_install="_ucld_::gh_cli_install"

echo
read -r -n 1 -p "Do you want to install GitHub CLI? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  _ucld_::gh_cli_install
fi

echo
read -r -n 1 -p "Do you want to authenticate to GitHub? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  _ucld_::gh_login
fi

echo
read -r -n 1 -p "Do you want to clone a repo? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  _ucld_::git_clone
fi
