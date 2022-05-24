#!/bin/bash
#
#SBATCH --mem 1GB
#SBATCH --cpus-per-task=1
#SBATCH -p fast

module load blast 

transcriptome=$1
uniprot=$2
output=$3

blastx -query $1 -db $2 -num_threads 1 -max_hsps 1 -outfmt "6 std stitle" -evalue 1e-10 > $3
