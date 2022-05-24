#!/bin/bash
#
#SBATCH --mem 4GB
#SBATCH -o log/snakemake.out.%A.out
#SBATCH -e log/snakemake.err.%A.err
#SBATCH --cpus-per-task=1
#SBATCH -p fast
module load snakemake
module load blast

snakemake --cores 1
