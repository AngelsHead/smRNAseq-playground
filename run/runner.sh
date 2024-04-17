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

#Renaming files
outdir=data/raw/fastq_renamed
mkdir $outdir
for oldname in data/raw/fastq/*fastq.gz; do
    newname=$outdir/$(basename $oldname | sed -E 's/(....).*(R[12]).*/\1_\2.fastq.gz/')
    ln -sv $PWD/$oldname $newname
done

module load miniconda3/23.3.1-py310
conda activate bbmap

#Single test
mkdir results/trimmed
bbduk.sh in=data/raw/fastq/R1-1_S1_L001_R1_001.fastq.gz in2=data/raw/fastq/R1-1_S1_L001_R2_001.fastq.gz out=results/trimmed/clean_R1.fq ref=data/ref/adapter.fasta ktrim=r k=23 mink=11 hdist=1 tpe tbo

#Setting variables
in1=data/raw/fastq/"*_R1_001.fastq.gz"
bash scripts/trimming.sh "$in1"

#Loop?
for in1 in data/raw/fastq_renamed/*_R1.fastq.gz; do
    sbatch scripts/trimming.sh "$in1" 
done

#--------------------------------------------------------
#MAPPING

#get annotated genome
module load miniconda3/23.3.1-py310
conda activate ncbi_datasets
datasets download genome accession GCA_009761285.1 --filename PRSTRT_AglyBT1_v1

#Lets try srnamapper instead of bowtie just for fun..
module load miniconda3/23.3.1-py310
conda activate srmamapper

module load bwa
bwa index data/ref/GCA_009761285.1_PRSTRT_AglyBT1_v1_genomic.fna

#test run with one
srnaMapper -r results/trimmed/clean_R1-1_R1.fq -g data/ref/GCA_009761285.1_PRSTRT_AglyBT1_v1_genomic.fna -o results/mapped/test.sam -t 1

sbatch scripts/mapping.sh

#--------------------------------------------------------
#QUANTIFICATION WITH SALMON 

#get transcriptome
curl https://sra-download.ncbi.nlm.nih.gov/traces/wgs03/wgs_aux/GB/SU/GBSU01/GBSU01.1.gbff.gz -o data/ref/agly_transcriptome.gz

#build SALMON index
salmon index -t data/ref/agly_transcriptome.gz -i agly_index