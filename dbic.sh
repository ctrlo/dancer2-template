#!/bin/bash

echo Using database APPNAME. Please enter the root password of the mysql database:
read PASSWORD

dbicdump -o dump_directory=./lib -o components='["InflateColumn::DateTime"]' APPNAME::Schema 'dbi:mysql:dbname=APPNAME' root $PASSWORD

