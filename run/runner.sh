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
datasets download genome accession GCA_009761285.1 --include gff3,rna,cds,protein,genome,seq-report
unzip ncbi_dataset.zip
mv ncbi_dataset data/ref

#Build index for genome
module load bwa
bwa index data/ref/ncbi_dataset/data/GCA_009761285.1/GCA_009761285.1_PRSTRT_AglyBT1_v1_genomic.fna

#Lets try srnamapper instead of bowtie just for fun..
module load miniconda3/23.3.1-py310
conda activate srmamapper

#test run with one
srnaMapper -r results/trimmed/clean_R1-1_R1.fq -g data/ref/ncbi_dataset/data/GCA_009761285.1/GCA_009761285.1_PRSTRT_AglyBT1_v1_genomic.fna -o results/mapped/test.sam -t 1

#Loop time
for in in results/trimmed/clean*; do
    sbatch scripts/mapping.sh "$in" 
done

#--------------------------------------------------------
#QUANTIFICATION WITH MMQUANT 
#I had to manually upload the genome file so it is in the correct format. It is agly_genome.gtf
module load miniconda3/23.3.1-py310
conda activate mmquant

#Testing one
mmquant -a data/ref/ncbi_dataset/data/GCA_009761285.1/genomic.gff -r results/mapped/clean_R1-1_R1.fq.sam

#Loop time
for map in results/mapped/clean*; do
    sbatch scripts/quant.sh "$map" 
done
