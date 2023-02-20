#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck disable=SC1091
{
  . "../common/main.sh"
  # more files
}

cat <<EOF

======================
 UCloud initiate apps
======================


The missing repo to start initiate apps on UCloud...

- Start GitHubbing: authenticate, clone, pull your repos.
- PostreSQL: install database and users, activate SSL.
- Django: deployment scripts.


author:
JV-conseil


version:
2023-02-17

EOF

echo
read -r -n 1 -p "Do you want to configure GitHub? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  cd "github/main.sh" || return
fi

echo
read -r -n 1 -p "Do you want to configure PostreSQL? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  cd "postgresql/main.sh" || return
fi

echo
read -r -n 1 -p "Do you want to configure Django? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  cd "django/main.sh" || return
fi
