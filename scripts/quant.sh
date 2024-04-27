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

#Run it
mmquant -a data/ref/ncbi_dataset/data/GCA_009761285.1/genomic.gff -r "$map" -o results/quant/"$map2" -O results/quant/stats/"$map2"
