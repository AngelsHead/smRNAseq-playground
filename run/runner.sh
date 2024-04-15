module load fastqc/0.11.8

# Run FastQC for each FASTQ file
for fastq_file in data/raw/fastq/*fastq.gz; do
    sbatch scripts/fastqc.sh "$fastq_file" results/fastqc
done