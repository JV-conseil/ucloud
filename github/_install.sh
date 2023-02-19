#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

echo
# read -r -n 1 -p "You are running $(python --version || :), do you want to upgrade to v3.11? [y/N] "
read -r -n 1 -p "Do you want to install packages for Linux with apt? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  _ucld_::install
fi
