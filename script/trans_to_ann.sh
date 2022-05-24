#!/bin/bash

transcript_list=$1
blast_result=$2
output_file=$3

while read line || [ -n "$line" ]; do
    if [[ $(grep "$line" $blast_result) ]]; then
        grep "$line" $blast_result | head -n 1 | cut -d'	' -f1,13 >> $output_file
    else
        echo -e "$line\tnone" >> $output_file
    fi
done < $transcript_list