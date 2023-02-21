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
  . "incl/all.sh"
  . "github/_api.sh"
  . "github/_utils.sh"
  # more files
}

cat "github/README.txt"

if ! [ -x "$(command -v gh)" ]; then

  echo
  read -r -n 1 -p "Do you want to install GitHub CLI? [y/N] "
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    _ucld_::gh_cli_install
  fi

fi

if [[ $(gh auth status &>>logfile.log) -ne 0 ]]; then

  echo
  read -r -n 1 -p "Do you want to authenticate to GitHub? [y/N] "
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    _ucld_::gh_login
  fi

else

  echo
  read -r -n 1 -p "Do you want to clone a repo? [y/N] "
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    _ucld_::git_clone
  fi

fi
