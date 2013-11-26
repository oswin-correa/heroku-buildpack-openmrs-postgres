#!/usr/bin/env bash

echo "-----> creating openmrs properties file in $HOME/.OpenMRS/openmrs-runtime.properties"

DB_USERNAME=`echo ${DATABASE_URL}| sed -E 's/postgres:\/\/([^:]+):(.*)/\1/'`
DB_PASSWORD=`echo ${DATABASE_URL}| sed -E 's/postgres:\/\/[^:]+:([^@]+)@.*/\1/'`
DB_HOSTNAME=`echo ${DATABASE_URL}| sed -E 's/postgres:\/\/[^@]+@//'`
DB_URL="jdbc:postgresql://${DB_HOSTNAME}&charSet=UTF-8"

mkdir -p $HOME/.OpenMRS
cat > $HOME/.OpenMRS/openmrs-runtime.properties <<EOF
#
# OpenMRS Runtime Properties file
#
 
### Database connection properties
connection.username=$DB_USERNAME
connection.password=$DB_PASSWORD
connection.url=$DB_URL
 
### Other
## Set the directory that OpenMRS uses for its application data
## Will be used as base dir for modules, generated reports, etc
## Defaults to C:/Docs&Settings/username/Application Data/OpenMRS for windows
## Defaults to ~/.OpenMRS for *nix
## (As of build 1.2.0.3426)
application_data_directory=${HOME}/package/target/distro
 
EOF
echo "       done"
