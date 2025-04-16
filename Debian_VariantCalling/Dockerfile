FROM debian

RUN apt update && apt install samtools bcftools bowtie2 snpeff -y
RUN mkdir -p /usr/local/work/
ADD bt2_genome /usr/local/work
WORKDIR /usr/local/work/

ENTRYPOINT ["/bin/sh"]