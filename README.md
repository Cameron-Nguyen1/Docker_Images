# I. Introduction

This repository is designed to provide easy access to source Dockerfiles used to faciltate a variety bioinformatics work.
Periodic updates may come as I collect images and files from past and future workflows.

### II. List of Images

## Debian_FastQC:
:star: Contains MultiQC, FastP, and FastQC. The purpose is QC.
```
docker pull cameronnguyen/qualitycontrol
```
## Debian_SRA_Toolkit:
:star: Contains SRAtoolkit. The purpose is to pull reads from SRA.
```
docker pull cameronnguyen/sratoolkit
```
## Debian_VariantCalling: 
:star: Contains Samtools, BCFtools, bowtie2. The purpose is to enable variant calling workflows.
```
docker pull cameronnguyen/variant_calling
```
