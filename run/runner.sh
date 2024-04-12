module load fastqc/0.11.8

fastq_file=$1
outdir=$2

fastqc --outdir "$outdir" "$fastq_file"