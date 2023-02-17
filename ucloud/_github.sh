#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================



gh_cli_install () {
    VERSION=$(curl "https://api.github.com/repos/cli/cli/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c2-)

    cat << EOF


Installing GitHub CLI v$VERSION...

GitHub CLI, or gh, is a command-line interface to GitHub for use in your terminal or your scripts.
https://cli.github.com/manual/

EOF

    mkdir "${PATH_TO_INSTALL_DIR}"
    ls
    cd "${PATH_TO_INSTALL_DIR}" || exit

    curl -sSL "https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz" -o "gh_${VERSION}_linux_amd64.tar.gz"
    tar xvf "gh_${VERSION}_linux_amd64.tar.gz"
    sudo cp "gh_${VERSION}_linux_amd64/bin/gh" /usr/local/bin/
    sudo cp -r "gh_${VERSION}_linux_amd64/share/man/man1/"* /usr/share/man/man1/

    back_to_script_dir_

    ls "${PATH_TO_INSTALL_DIR}"
    gh version
}



echo
read -r -n 1 -p "Do you want to install GitHub CLI? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then
    gh_cli_install
fi



gh_login () {
    cat << EOF


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
alias login="gh_login"



echo
read -r -n 1 -p "Do you want to authenticate to GitHub? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then
    gh_login
fi



git_clone () {
    gh repo list
    # gh repo list JV-conseil --visibility public

    cat << EOF

Choose one of the repo listed above to clone it as such

cd "${PATH_TO_WORK_DIR}" || exit
gh repo clone {gh-owner}/{gh-repo}

EOF
}
alias clone="git_clone"



echo
read -r -n 1 -p "Do you want to clone a repo? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git_clone
fi



git_pull () {
    back_to_script_dir_
    cd_ ..
    git pull
    back_to_script_dir_
}
alias update="git_pull"
