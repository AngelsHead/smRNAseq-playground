#Create all environemtns necessary to run this workflow

module load miniconda3/23.3.1-py310

conda create -y -n multiqc -c bioconda multiqc
conda create -y -n bbmap -c bioconda bbmap
conda create -y -n ncbi_datasets -c bioconda ncbi_datasets
conda create -y -n srmamapper -c bioconda srnamapper        #I made a typo in the name when making it. So i kept the typo here for reproducability
conda create -y -n mmquant -c bioconda mmquant