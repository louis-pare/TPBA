#!/bin/bash


out_file=$1

function insert_sep {
echo -e "\n_______________________________________\n" >> $1
}

echo -e "TBT pipeline succesfully ran !\n" > $out_file

for files in "$@";
do
    if [[ $files != $out_file ]];
    then

        proteome=$( basename $files | cut -d"_" -f1 )
        nb_of_line=$( cat "$files" | wc -l )
        nb_of_none=$( grep -c "none" "$files" )
        insert_sep "$out_file"
        echo -e "> $proteome statistics:\n" >> $out_file
        echo -e "- Number of transcript with annotation: $( expr $nb_of_line - $nb_of_none )\n" >> $out_file
        echo -e "- Number of transcript without annotation: $nb_of_none\n" >> $out_file
        echo -e "- Total number of transcript: $nb_of_line\n" >> $out_file
    fi
done

