#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# Generating a new SSH key and adding it to the ssh-agent
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
#
#====================================================

_ucld_::generate_ssh_key() {
  local _password _file

  _file="id_ed25519_ucloud"
  _password="$(_ucld_::key_gen 32)"

  if ssh-keygen -t ed25519 -N "${_password}" -f "${UCLD_PATH[env]}/${_file}"; then

    echo "${_file}:${_password}" >>"${UCLD_PATH[env]}/.passfile"

    cat <<EOF

Keep the passphrase used to generate the key:
${_password}

It  has been saved also in ${UCLD_PATH[env]}/.passfile

On UCloud navigate to UCloud > Resources > SSH Keys > Create SSH key
https://cloud.sdu.dk/app/ssh-keys/create

Title:
ucloud

Public key:
EOF
    cat "${UCLD_PATH[env]}/${_file}.pub"
    echo

    if [[ $(_ucld_::is_ucloud_execution) == false ]]; then

      if "$(_ucld_::ask "For Mac OS X, do you want to store your passphrase in the keychain")"; then
        cp "${UCLD_PATH[env]}/${_file}" "${HOME}/.ssh/${_file}"
        cp "${UCLD_PATH[env]}/${_file}.pub" "${HOME}/.ssh/${_file}.pub"
        ssh-add --apple-use-keychain "${UCLD_PATH[env]}/${_file}" -t 31536000
      fi

    fi

  fi

}
