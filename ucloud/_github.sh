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

    mkdir "${UCLOUD_INSTALL_DIR}"
    ls
    cd "${UCLOUD_INSTALL_DIR}" || exit

    curl -sSL "https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz" -o "gh_${VERSION}_linux_amd64.tar.gz"
    tar xvf "gh_${VERSION}_linux_amd64.tar.gz"
    sudo cp "gh_${VERSION}_linux_amd64/bin/gh" /usr/local/bin/
    sudo cp -r "gh_${VERSION}_linux_amd64/share/man/man1/"* /usr/share/man/man1/

    back_to_script_dir_

    ls "${UCLOUD_INSTALL_DIR}"
    gh version
}


echo
read -r -n 1 -p "Do you want to install GitHub CLI? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then
    gh_cli_install
fi



echo
read -r -n 1 -p "Do you want to authenticate to GitHub? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then

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

fi


git_clone () {
    cat << EOF


Cloning repo ${GH_ORG}/${GH_REPO} into ${UCLOUD_WORK_DIR}...

EOF

    cd "${UCLOUD_WORK_DIR}" || exit

    gh repo clone "${GH_ORG}/${GH_REPO}"

    back_to_script_dir_
}


echo
read -r -n 1 -p "Do you want to clone the repo ${GH_ORG}/${GH_REPO}? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then

    git_clone

fi


git_pull () {
    cat << EOF


Pulling repo "${GH_ORG}/${GH_REPO}"...

EOF

    cd "${UCLOUD_APP_DIR}" || exit

    git pull
    ls

    cat << EOF


Updating ${UCLOUD_SCRIPT_DIR}...

EOF

    rm -rf "${UCLOUD_SCRIPT_DIR}"
    cp -rf "${UCLOUD_APP_DIR}/${GH_UCLOUD_DIR}" "${UCLOUD_WORK_DIR}"

    back_to_script_dir_
}
alias gitpull="git_pull"


echo
read -r -n 1 -p "Do you want to pull the repo ${GH_ORG}/${GH_REPO}? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then

    git_pull

fi
