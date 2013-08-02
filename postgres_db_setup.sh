#!/bin/bash
# Generic db setup script

if [ ! $DB_USER ] || [ ! $DB_PWD ] || [ ! $OS_USER ]
then
    echo "usage:  OS_USER=<os_user> DB_USER=<db_user> DB_PWD=<db_pwd> postgres_db_setup.sh"
    echo "DB_USER and database name will be the same"
    exit 1
fi

# add .pgpass pwd file to eliminate password prompt for os user to connect as db user
sudo -u $OS_USER -s echo "*:*:*:$DB_USER:$DB_PWD" >> ~/.pgpass; chmod 600 .pgpass

# create user and set password
sudo -u postgres -i psql -c "CREATE ROLE $DB_USER SUPERUSER LOGIN PASSWORD '$DB_PWD';"

# create database
sudo -u postgres -i  psql -c "CREATE DATABASE $DB_USER OWNER $DB_USER;" 
