#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
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

declare -a UCLOUD_SSH_PATH

UCLOUD_SSH_KEY="id_ed25519_ucloud"

UCLOUD_SSH_PATH=("${HOME}/.ssh" "${UCLD_PATH[env]}/.ssh")

_ucld_::update_ssh_config() {
  local _config _path

  for _path in "${UCLOUD_SSH_PATH[@]}"; do
    _config="${_path}/config"
    touch "${_config}"

    if grep -q "${UCLOUD_SSH_KEY}" "${_config}" 2>>logfile.log; then
      continue
    fi

    cat <<<"Host ""${HOSTNAME}""
  Hostname ""${HOSTNAME}""
  User ""${USER}""
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ""${UCLOUD_SSH_PATH[0]}/${UCLOUD_SSH_KEY}""" >>"${_config}"

  done

}

_ucld_::update_ssh_agent() {
  local _lifetime=$(((365 / 2) * 24 * 60 * 60))

  if eval "$(ssh-agent -s)"; then

    cat <<EOF

The passphrase used to generate the key has been copied to your clipboard.

Paste this passphrase below 👇

EOF

    if _ucld_::is_ucloud_env; then
      ssh-add -t "${_lifetime}" "${UCLOUD_SSH_PATH[0]}/${UCLOUD_SSH_KEY}"
    else
      ssh-add -t "${_lifetime}" --apple-use-keychain "${UCLOUD_SSH_PATH[0]}/${UCLOUD_SSH_KEY}"
    fi

    _ucld_::h2 "${UCLOUD_SSH_KEY} successfully added to the ssh agent"
    ssh-add -l
  fi
}

_ucld_::resources_storing() {
  cat <<EOF

On UCloud navigate to UCloud > Resources > SSH Keys > Create SSH key
https://cloud.sdu.dk/app/ssh-keys/create

Title:
ucloud

Public key:
$(cat "${UCLOUD_SSH_PATH[1]}/${UCLOUD_SSH_KEY}.pub")

EOF
}

_ucld_::update_passfile() {
  local _path
  for _path in "${UCLOUD_SSH_PATH[@]}"; do
    echo "${UCLOUD_SSH_KEY}:${1}" >>"${_path}/passfile"
  done
}

_ucld_::generate_ssh_key() {
  local _password

  _password="$(_ucld_::key_gen 32)"

  mkdir "${UCLOUD_SSH_PATH[1]}" || :

  if ssh-keygen -t ed25519 -N "${_password}" -C "${USER}@${HOSTNAME}" -f "${UCLOUD_SSH_PATH[1]}/${UCLOUD_SSH_KEY}"; then

    chmod 400 "${UCLOUD_SSH_PATH[1]}/${UCLOUD_SSH_KEY}"*

    if sudo cp -pv "${UCLOUD_SSH_PATH[1]}/${UCLOUD_SSH_KEY}"* "${UCLOUD_SSH_PATH[0]}"; then

      if _ucld_::is_xclip_installed; then
        echo "${_password}" | xclip -selection clipboard &>/dev/null || :
      else
        echo "${_password}" | pbcopy &>/dev/null || :
      fi

      _ucld_::update_passfile "${_password}"
      _ucld_::update_ssh_config
      _ucld_::update_ssh_agent
      _ucld_::resources_storing

    fi

  fi

}
