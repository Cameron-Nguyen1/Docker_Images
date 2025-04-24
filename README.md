# I. Introduction

This repository is designed to provide easy access to source Dockerfiles used to faciltate a variety bioinformatics work.
Periodic updates may come as I collect images and files from past and future workflows.

# II. List of Images

## Debian_FastQC:
:star: Contains MultiQC, FastP, and FastQC. The purpose is QC. Used in the project: https://github.com/Cameron-Nguyen1/VCANN-WDL
```
docker pull cameronnguyen/qualitycontrol:latest
```
## Debian_SRA_Toolkit:
:star: Contains SRAtoolkit. The purpose is to pull reads from SRA. Used in the project: https://github.com/Cameron-Nguyen1/VCANN-WDL
```
docker pull cameronnguyen/sratoolkit:latest
```
## Debian_VariantCalling: 
:star: Contains Samtools, BCFtools, Bowtie2, snpEff, and a small snpEff database. The purpose is to enable variant calling workflows. Used in the project: https://github.com/Cameron-Nguyen1/VCANN-WDL
```
docker pull cameronnguyen/variant_calling:latest
```
## Antigenic Cartograhpy
:star: Designed to run antgenic cartography on a .csv format file. Used in the following projects: (https://github.com/Cameron-Nguyen1/AWS-Lambda-AgCartography, https://github.com/Cameron-Nguyen1/N204_data_availability)
```
docker pull cameronnguyen/cvrg-variant-calling:version1
```
