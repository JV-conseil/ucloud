#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

ucl() {
  case "${1:-}" in

  "django")
    # shellcheck source=/dev/null
    . ".bash/osx/django.sh"
    ;;

  "homebrew" | "brew")
    # shellcheck source=/dev/null
    . ".bash/osx/homebrew.sh"
    ;;

  "pipenv")
    # shellcheck source=/dev/null
    . ".bash/osx/pipenv.sh"
    ;;

  "postgresql" | "pg")
    # shellcheck source=/dev/null
    . "/work/ucloud/postgresql/main.sh"
    ;;

  *)
    cat <<EOF


Bash Commands Lines ucl
----------------------

e.g.: wl django


options:
django      Django commands to startproject, startapp and set up PostgreSQL for this repository.
homebrew    Homebrew installs the stuff you need that Apple (or your Linux system) didn’t (alias brew).
pipenv      Pipenv Shell to run commands like: python manage.py makemigrations.
postgresql  PostgreSQL CLI terminal and commands to create a Database and DB User for this repository (alias pg).


author:
JV conseil — Internet Consulting
contact@jv-conseil.net
@JV-conseil

version:
2023-03-11
EOF
    ;;

  esac
}
