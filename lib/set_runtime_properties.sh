#!/usr/bin/env bash

echo "-----> creating openmrs properties file in $HOME/.OpenMRS/openmrs-runtime.properties"

DB_USERNAME=`echo ${CLEARDB_DATABASE_URL}| sed -E 's/mysql:\/\/([^:]+):(.*)/\1/'`
DB_PASSWORD=`echo ${CLEARDB_DATABASE_URL}| sed -E 's/mysql:\/\/[^:]+:([^@]+)@.*/\1/'`
DB_HOSTNAME=`echo ${CLEARDB_DATABASE_URL}| sed -E 's/mysql:\/\/[^@]+@//'`
DB_URL=jdbc:mysql://${DB_HOSTNAME}

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

echo "-----> running database setup"

$HOME/.maven/bin/mvn -B -Duser.home=$HOME -Dmaven.repo.local=$HOME/.m2/repository -s $HOME/.m2/settings.xml -Psetupdatabase generate-resources -Ddb.url=$DB_URL -Ddb.user=$DB_USERNAME -Ddb.password=$DB_PASSWORD