#!/bin/perl
#SBATCH --account=PAS2700
#SBATCH --time=6:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm-piRNA-trimming-%j.out
set -euo pipefail

module load miniconda3/23.3.1-py310
conda activate srmamapper

perl sRNAmapper.pl -input data/raw/fastq/R1-1_S1_L001_R1_001.fastq.gz -genome data/ref/PRSTRT_AglyBT1_v1 -format sam -alignments best