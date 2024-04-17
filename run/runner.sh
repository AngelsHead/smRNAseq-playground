#FASTQC ANALYSIS

module load fastqc/0.11.8
# Run FastQC for each FASTQ file
for fastq_file in data/raw/fastq/*fastq.gz; do
    sbatch scripts/fastqc.sh "$fastq_file" results/fastqc
done

#----------------------------------------------------------
#MULTIQC
module load miniconda3/23.3.1-py310
conda activate multiqc
multiqc results/fastqc

#---------------------------------------------------------
#TRIMMING
module load miniconda3/23.3.1-py310
conda activate bbmap

#Single test
mkdir results/trimmed
bbduk.sh in=data/raw/fastq/R1-1_S1_L001_R1_001.fastq.gz in2=data/raw/fastq/R1-1_S1_L001_R2_001.fastq.gz out=results/trimmed/clean_R1.fq ref=data/ref/adapter.fasta ktrim=r k=23 mink=11 hdist=1 tpe tbo

#Setting variables
in1=data/raw/fastq/"*.gz"
bash scripts/trimming.sh "$in1"

#Loop?
for in1 in data/raw/fastq/*_R1_001.fastq.gz; do
    sbatch scripts/trimming.sh "$in1" 
done


#--------------------------------------------------------
#MAPPING

#get annotated genome
conda activate ncbi_datasets
datasets download genome accession GCA_009761285.1 --filename PRSTRT_AglyBT1_v1

#Lets try srnamapper instead of bowtie just for fun..
module load miniconda3/23.3.1-py310
conda activate srmamapper

#test run with one
perl sRNAmapper.pl -input data/raw/fastq/R1-1_S1_L001_R1_001.fastq.gz -genome data/ref/PRSTRT_AglyBT1_v1 -format sam -alignments best