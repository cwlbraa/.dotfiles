#!/usr/bin/env bash

if [ -z "$1" ]
then
    echo "please supply a program to execute"
    exit 1
fi

if [ -z "$2" ]
then
    echo "please supply that program's class"
    exit 1
fi

i3-msg -t get_tree | jq . \
    | grep "\"class\": \"${2}\"" \
    && exit 0

$1
