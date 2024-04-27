# Welcome to my Playground
--------
## Proposal 
The goal of this progect is to start learning how to process small RNAseq data, specifically looking for piRNAs. I want to learn and gain pracitce with *fastqc/multiqc, trimming, and mapping/alignment.*

I will be using the small dataset I currently have, with three samples each having paired end reads (for a total of six files.) My goal, however, is to make scripts that I can use for future sequence data when I recieve it. 

This mini project will directly help me in my research, as my goal is to have a chapter dedicated to this piRNA seq data. I currently have very little experience in bioinformatics, so this project will help me get started and learn in a practical hands-on way. Additionally, I am a major fan of effiency and automation, so I'm also very eager and excited to learn the full power of bioinformatic skills. "You don't know what you don't know," so I'm very interested to learn what exactly I dont know, and things I never would have thought I could do!

### Technical Aspects

Areas of uncertainty for me are currently how to trim for piRNAs, and how to map them. We have not covered this in class, and additionally as we have spoken in person, mapping piRNAs specifically is more complicated than it sounds. For the purposes of this project, however, a simple genome mapping will hopefully suffice, though I am unsure of how to do this currently. 

I am also a bit uncertain how exactly I will set up my scripts at this time. I anticipate I will use loops for the fastqc and multiqc checks. I also anticipate that I will have seperate scripts for the fastqc and trimming steps. Then likely I will use the results from those to check the quality using multiqc. Based on my current knowledge of these programs, I anticipate I would need seperate scrips and runner scripts for each of these processes, though perhaps I will be able to truncate some of them as the project develops. I also believe I would utilize slurm batch jobs here for each of these steps (fastqc, trimming, and multiqc).

Along with the extra programs fastqc, multiqc, and trimgalore, I expect to use a genome mapping tool such as bowtie. As I do not have experience in this yet and I am unsure of how it works, I might have the same situation as above too with seperate scripts, runners, and slurm jobs. 

------------
# Final Status
## Background
This project aims to complete certain introductory steps for processing small RNA seq data. The data used comes from the soybean aphid, *Aphis glycines*. Certain soybean aphid biotypes have aquired adaptations to allow them to overcome plant defenses, and preliminary evidence suggests these adaptations might have an epigenetic basis. I have observed that adapted aphid biotypes overexpress PIWI protiens, which are used in epigenetic gene regulation. They do this by binding with a specific class of smRNAs called piRNAs, which guide the PIWI complex by matching the sequenes in need of regulation. **Thus, the goal of this project is to sequence piRNAs in both aphid biotypes in order to compare sequences and levels of expression.**

To achieve this, I have prepared scripts to start the processing of final sequence data. The scripts here perfom the following preprocessing and quantification steps:
| Function                 | Script         |
| -----------              | -----------    |
| Quality Check            | `fastqc.sh`    |
| Multiqc Report           | `multiqc.sh`   |
| Read Trimming            | `trimming.sh`  |
| Read Mapping             | `mapping.sh`   |
| Quantifying Mapped Reads | `quant.sh`     |

My current preliminary samples are from the non-adapted aphid biotype after feeding on resistant soybeans for 12 hours. I extracted RNA from whole-body aphids and enriched samples for miRNAs. Samples were sequenced using a Nextflex small RNA-seq kit v4 by Perkin Elmer. The adapter sequences correspond to Illumina TruSeq sRNA, and these were mannually entered in `data/ref/adapter.fasta`.  

## Running this code
If you are looking to replicate this workflow, first you must navigate to `/fs/ess/PAS2700/users/guppyshead/smRNAseq-playground` as all scripts assume you are located there. Additionally, you will need to create the apropriate conda environments by running everything in `run/create_enviros.sh`. 

All workflow steps are run through the runner script (`run/runner.sh`). It is structured such that each section can be run independantly (i.e. you do not have to start at the top and run everything). Additionally, each section has a single file test line that does not need to be rerun and is kept in for documentation/review purposes. 

## Final considerations
While this workflow works and produces results, it is not meant to be a complete and final analysis of my data. As I am working with piRNAs in a non-model species, smRNA databases are lacking sufficient reference transcriptomes for my purposes. For this class and to test the functionality of my scripts and programs I chose to use, I mapped to the overal genome rather than a smRNA specific reference. For future research and publication worthy data processing, this step will have to be altered. 