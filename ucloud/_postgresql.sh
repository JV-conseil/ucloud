#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# Set Up a PostgreSQL Database on Linux
# https://www.microfocus.com/documentation/idol/IDOL_12_0/MediaServer/Guides/html/English/Content/Getting_Started/Configure/_TRN_Set_up_PostgreSQL_Linux.htm
#
#====================================================



pg_start () {
    sudo service postgresql start
    sudo -u postgres psql --dbname=postgres --command="\l+"
    sudo -u postgres psql --dbname=postgres
}


pg_stop () {
    sudo service postgresql stop
}


pg_load () {

    __commands=(
        "CREATE DATABASE ${PG_DB_NAME}"
        "CREATE ROLE root IN ROLE postgres"
    )

    for __cmd in "${__commands[@]}"
    do
        echo "${__cmd} ;"
        sudo -u postgres psql --dbname=postgres --command="${__cmd} ;"
    done

    # shellcheck disable=SC2024
    sudo -u postgres psql --dbname="${PG_DB_NAME}" < "${PG_DB_DUMP}"

}


echo
read -r -n 1 -p "Do you want to start postgresql server? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then

    pg_start

fi


echo
read -r -n 1 -p "Do you want to load an sql dump into database? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then

    pg_load
    pg_start

fi
