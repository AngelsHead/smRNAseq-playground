#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=6:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm-piRNA-mapping-%j.out
#SBATCH --cpus-per-task=10
set -euo pipefail

#HARDCODED OUTDIR AND GENOME 

module load miniconda3/23.3.1-py310
conda activate srmamapper

#Set variables
in="$1"
fileid=$(basename $in)
outdir=results/mapped
mkdir -p "$outdir"                              #Make outdir if needed
out="$outdir"/"$fileid".sam
genome=data/ref/ncbi_dataset/data/GCA_009761285.1/GCA_009761285.1_PRSTRT_AglyBT1_v1_genomic.fna

#Generate nice text
echo "# Starting script mapping.sh"
date
echo "# Input file:   $in"
echo "# Output dir:   $out"
echo

#Run it
srnaMapper -r "$in" -g "$genome" -o "$out" -t 10

# Final reporting
echo
echo "# Done running, good job!"
date