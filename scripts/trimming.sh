#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=6:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm-piRNA-trimming-%j.out
set -euo pipefail

module load miniconda3/23.3.1-py310
conda activate bbmap

#Setting variables
in1=$1                          #bc you will put this dir exactly as an agurment
in2=${in1/_R1/_R2}
output=results/trimmed/clean_"$in1".fq
aref=data/ref/adapter.fasta

#script w/ VARIABLES
bbduk.sh in="$in1" in2="$in2" out="$output" ref="$aref" ktrim=r k=23 mink=11 hdist=1 tpe tbo
