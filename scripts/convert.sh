#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=6:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm-map-convert-%j.out
set -euo pipefail

#Variables 
map1="$1"
output=$(basename "$map1")

grep -v ^@ "$map1" | awk '{print "@"$1"\n"$10"\n+\n"$11}' > results/mapped/converted/"$output".fastq