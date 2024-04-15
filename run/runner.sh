module load fastqc/0.11.8

# Defining variables
outdir=results/fastqc

fastq_file=$1

#testing
# Standard universal start
module load fastqc
fastq_file=$1                                   #Copy the placeholder variables
outdir=$2
echo "# Starting script fastqc.sh"              #Generate nice text
date
echo "# Input FASTQ file:   $fastq_file"
echo "# Output dir:         $outdir"
echo
mkdir -p "$outdir"                              #Make outdir if needed

#Run one fastqc to see if it worked
fastqc --outdir "$outdir" "$fastq_file"

# Final reporting
echo
echo "# Done with script fastqc.sh"
date


# Run FastQC for each FASTQ file
#for fastq_file in smRNAseq-playground/data/raw/*fastq.gz; do
    sbatch scripts/fastqc.sh "$fastq_file" results/fastqc
#done