#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# shellcheck source=/dev/null
#
#====================================================

# shellcheck disable=SC1091
. "incl/all.sh"

cat "README.txt"

echo
read -r -n 1 -p "Do you want to install packages for Linux with apt? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  . incl/install.sh
fi

echo
read -r -n 1 -p "Do you want to manage GitHub? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  . github/main.sh
fi

echo
read -r -n 1 -p "Do you want to manage PostreSQL? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  . postgresql/main.sh
fi

echo
read -r -n 1 -p "Do you want to manage Django? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  . django/main.sh
fi

echo
read -r -n 1 -p "Do you want to run a Python app? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  . app/main.sh
fi
