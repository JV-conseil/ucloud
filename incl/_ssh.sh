#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# SSH Login
# <https://docs.hpc-type3.sdu.dk/intro/ssh-login.html#generate-a-new-ssh-key>
#
# Generating a new SSH key and adding it to the ssh-agent
# <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>
#
#====================================================

declare -A UCLOUD_SSH_KEY

UCLOUD_SSH_KEY=(
  [key]="id_ed25519_ucloud"
  [path]="${HOME}/.ssh"
  [path_env]="${UCLD_PATH[env]}/.ssh"
)

_ucld_::update_ssh_config() {
  local _config _config_home

  _config="${UCLOUD_SSH_KEY[path_env]}/config"
  _config_home="${UCLOUD_SSH_KEY[path]}/config"

  touch "${_config}"

  cat <<<"
# ucloud
Host ""${HOSTNAME}""
  Hostname ""${HOSTNAME}""
  User ""${USER}""
" >>"${_config}"

  if [[ $(_ucld_::is_ucloud_execution) == true ]]; then
    cat "${_config}" >>"${_config_home}"
    # shellcheck disable=SC1090
    . "${_config_home}"
  fi
}

_ucld_::update_ssh_agent() {
  local _lifetime=31536000

  eval "$(ssh-agent -s)"

  if [[ $(_ucld_::is_ucloud_execution) == true ]]; then
    ssh-add "${UCLOUD_SSH_KEY[path]}/${UCLOUD_SSH_KEY[key]}" -t "${_lifetime}"
  else
    ssh-add --apple-use-keychain "${UCLOUD_SSH_KEY[path]}/${UCLOUD_SSH_KEY[key]}" -t "${_lifetime}"
  fi

  _ucld_::h2 "${UCLOUD_SSH_KEY[key]} successfully added to the ssh agent"
  ssh-add -l
}

_ucld_::resources_storing() {
  cat <<EOF

On UCloud navigate to UCloud > Resources > SSH Keys > Create SSH key
https://cloud.sdu.dk/app/ssh-keys/create

Title:
ucloud

Public key:
$(cat "${UCLOUD_SSH_KEY[path_env]}/${UCLOUD_SSH_KEY[key]}.pub")

EOF
}

_ucld_::generate_ssh_key() {
  local _password _passfile

  # _key="id_ed25519_ucloud"
  # _path="${UCLD_PATH[env]}/.ssh"
  _password="$(_ucld_::key_gen 32)"
  _passfile="${UCLOUD_SSH_KEY[path_env]}/.passfile"

  mkdir "${UCLOUD_SSH_KEY[path_env]}"

  if ssh-keygen -t ed25519 -N "${_password}" -C "${USER}@${HOSTNAME}" -f "${UCLOUD_SSH_KEY[path_env]}/${UCLOUD_SSH_KEY[key]}"; then

    cat <<EOF

Keep the passphrase used to generate the key:
${_password}

It has been saved also under:
${_passfile}

Enter this passphrase below 👇

EOF

    echo "${UCLOUD_SSH_KEY[key]}:${_password}" >>"${_passfile}"

    # sudo
    cp -r "${UCLOUD_SSH_KEY[path_env]}/"* "${HOME}/.ssh/"

    _ucld_::update_ssh_config
    _ucld_::update_ssh_agent
    _ucld_::resources_storing

  fi

}
