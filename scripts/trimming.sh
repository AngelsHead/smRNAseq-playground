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
fileid=$(basename $in1 .fastq.gz)

outdir=results/trimmed
mkdir -p "$outdir"                              #Make outdir if needed

output="$outdir"/clean_"$fileid".fq
aref=data/ref/adapter.fasta

#Run it
bbduk.sh in="$in1" in2="$in2" out="$output" ref="$aref" ktrim=r k=23 mink=11 hdist=1 tpe tbo

# Final reporting
echo
echo "# Done running, good job!"
date