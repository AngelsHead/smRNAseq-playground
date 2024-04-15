#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=6:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm-piRNA-fastqc-%j.out
set -euo pipefail

module load fastqc/0.11.8

fastq_file=$1                                   #define variables
outdir=$2
echo "# Starting script fastqc.sh"              #Generate nice text
date
echo "# Input FASTQ file:   $fastq_file"
echo "# Output dir:         $outdir"
echo
mkdir -p "$outdir"                              #Make outdir if needed

# Run FastQC
fastqc --outdir "$outdir" "$fastq_file"

# Final reporting
echo
echo "# Done with script fastqc.sh"
date