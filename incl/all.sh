#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# license       : EUPL-1.2 license
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck source=/dev/null
{
  . "incl/__set.sh" || "/work/ucloud/incl/__set.sh"
  . "incl/__aliases.sh" || "/work/ucloud/incl/__aliases.sh"
  . "incl/__debug.sh" || "/work/ucloud/incl/__debug.sh"
  . "incl/__utils.sh" || "/work/ucloud/incl/__utils.sh"
  . "incl/__colors.sh" || "/work/ucloud/incl/__colors.sh"
  # below this line depends on ./settings.conf
  . "incl/_path.sh" || "/work/ucloud/incl/_path.sh"
  . "incl/_exceptions.sh" || "/work/ucloud/incl/_exceptions.sh"
  . "incl/_skeleton.sh" || "/work/ucloud/incl/_skeleton.sh"
  . "incl/_settings.sh" || "/work/ucloud/incl/_settings.sh"
  . "incl/_install.sh" || "/work/ucloud/incl/_install.sh"
  . "incl/_ssh.sh" || "/work/ucloud/incl/_ssh.sh"
  # more files
}
