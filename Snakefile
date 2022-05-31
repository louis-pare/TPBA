import os
from script.snakefile_functions import verify_output_directory
configfile: "config.yaml"

config["output_directory"] = verify_output_directory(config["output_directory"])
proteome_list = os.listdir(config["proteomes"])
blast_to_use = "blastx" if config["is_transcriptome"] == "yes" else "blastp"

#
rule all:
    input:
        config["output_directory"] + "Statistics.txt"

# Take all proteome in given proteome folder path and create
# the corresponding database with makeblastdb.
rule makeblastdb:
    input:
        config["proteomes"] + "/{proteome_list}"
    output:
        config["output_directory"] + "blastdb/{proteome_list}"
    shell:
        """
        ln -s {input} {output}
        makeblastdb -in {output} -dbtype prot
        """

rule blastx:
    input:
        proteomes = config["output_directory"] + "blastdb/{proteome_list}",
        transcriptome = config["transcriptome"]
    output:
        config["output_directory"] + "blast_result/{proteome_list}_blastx.txt"
    threads:
        config["threads"]
    params:
        cutoff = config["evalue"],
        blast_to_use = blast_to_use
    shell:
        """
        {params.blast_to_use} -query {input.transcriptome} -db {input.proteomes} \\
        -num_threads {threads} -max_hsps 1 -outfmt \"6 std stitle\" \\
        -evalue {params.cutoff} > {output}
        """

# generate a file listing all transcripts.
rule transcript_list:
    input:
        transcriptome = config["transcriptome"]
    output:
        config["output_directory"] + "transcript_list.txt"
    shell:
        "grep \"^>\" {input} | cut -d ' ' -f1 | tr -d \">\" | sort | uniq > {output}"

rule transcript_to_annotation:
    input:
        trans_list=config["output_directory"] + "transcript_list.txt",
        blast=config["output_directory"] + "blast_result/{proteome_list}_blastx.txt"
    output:
        config["output_directory"] + "{proteome_list}_transcript_to_annotation.txt"
    shell:
    # bash script/trans_to_ann.sh {input.trans_list} {input.blast} {output}
        """
        cat {input.blast} | cut -f1,13 | sort -u -k1,1 > {output}
        cat {output} | cut -f1 > {output}tmp.txt
        res=$( cat  {output}tmp.txt {input.trans_list} | sort | uniq -u )
        for i in $res; do
            echo -e "${i}\tnone" >> {output}
        done
        rm {output}tmp.txt
        """

rule compute_statistics:
    input:
        expand(config["output_directory"] + "{proteome_list}_transcript_to_annotation.txt", proteome_list = proteome_list)
    output:
        config["output_directory"] + "Statistics.txt"
    shell:
        "bash script/compute_statistics.sh {output} {input}"

