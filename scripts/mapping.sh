#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=6:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm-piRNA-mapping-%j.out
#SBATCH --cpus-per-task=10
set -euo pipefail

module load miniconda3/23.3.1-py310
conda activate srmamapper

srnaMapper -r results/trimmed/clean_R1-1_R1.fq -g data/ref/GCA_009761285.1_PRSTRT_AglyBT1_v1_genomic.fna -o results/mapped/test.sam -t 10
