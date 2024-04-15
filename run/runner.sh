#FASTQC ANALYSIS

module load fastqc/0.11.8
# Run FastQC for each FASTQ file
for fastq_file in data/raw/fastq/*fastq.gz; do
    sbatch scripts/fastqc.sh "$fastq_file" results/fastqc
done

#----------------------------------------------------------
#MULTIQC
conda activate multiqc
multiqc results/fastqc

#---------------------------------------------------------
#TRIMGALORE


#--------------------------------------------------------
#MAPPING

#get annotated genome
conda activate ncbi_datasets
datasets download genome accession GCA_009761285.1 --filename PRSTRT_AglyBT1_v1

#Lets try srnamapper instead of bowtie just for fun..
conda activate srmamapper

#test run with one
perl sRNAmapper.pl -input data/raw/fastq/R1-1_S1_L001_R1_001.fastq.gz -genome data/ref/PRSTRT_AglyBT1_v1 -format sam -alignments best