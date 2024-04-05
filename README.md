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
