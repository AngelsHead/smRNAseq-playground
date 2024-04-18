#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=6:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm-piRNA-mapping-%j.out
#SBATCH --cpus-per-task=10
set -euo pipefail

module load miniconda3/23.3.1-py310
conda activate srmamapper

#Set variables
in="$1"
fileid=$(basename $in)
out=results/mapped/"$fileid".sam
genome=data/ref/GCA_009761285.1_PRSTRT_AglyBT1_v1_genomic.fna

srnaMapper -r "$in" -g "$genome" -o "$out" -t 10
