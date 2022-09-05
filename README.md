# Transcript or Protein Blast Annotation.

## What is it?

This snakemake pipeline take as input either a transcriptome or a proteome and a list of proteomes to find homologuous proteins using blast.

## How to make it work?

To make this snakemake pipeline works, you need to install [snakemake](https://snakemake.readthedocs.io/en/stable/) and [blast](https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download).

After installation, you will need to complete the config.yaml file, then the pipeline can be launched using the snakemake command.

## Output description

The pipeline will generate several outputs into the given output directory. Firstly, it will create a blastdb folder in which the blast databases will be saved.

The second folder named blast_result will contain the raw blast results for each proteomes.

A text file will be created for each given proteomes with the given format: transcript (tab) homologuous protein.

Finally, a text file called "Statistcs.txt" will contain the proportion of transcript containing a homologuous protein in each proteomes.