#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=6:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm-piRNA-quant-%j.out
#SBATCH --cpus-per-task=1
set -euo pipefail

module load miniconda3/23.3.1-py310
conda activate mmquant

#Set variables
map="$1"
map2=$(basename "$map")
outdir=results/quant
outdir2="$outdir"/stats
mkdir -p "$outdir"                              #Make outdir if needed
mkdir -p "$outdir2"                             #Make outdir if needed

#Generate nice text
echo "# Starting script quant.sh"
date
echo "# Input file:   $map"
echo "# Output dir:   $outdir"
echo


#Run it
mmquant -a data/ref/ncbi_dataset/data/GCA_009761285.1/genomic.gff -r "$map" -o "$outdir"/"$map2" -O "$outdir2"/"$map2"

#Final reporting
echo
echo "# Done running, good job!"
date