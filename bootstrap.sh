#!/bin/bash

if [ ! $# == 1 ]; then
    echo "Usage: $0 APPNAME"
    exit
fi

mkdir lib/$1
mv lib/APPNAME.pm lib/$1.pm

find . -type f ! -path '*/\.*' ! -name bootstrap.sh -exec sed -i "s/APPNAME/$1/g" {} \;

