#!/bin/bash
#
#SBATCH --mem 8GB
#SBATCH -o log/snakemake.out.%A.out
#SBATCH -e log/snakemake.err.%A.err
#SBATCH --cpus-per-task=12
#SBATCH -p fast
module load snakemake
module load blast

snakemake --cores 12
