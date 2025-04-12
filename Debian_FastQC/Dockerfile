FROM debian

RUN apt update && apt install fastqc multiqc fastp -y
    

RUN mkdir -p /usr/local/work/
WORKDIR /usr/local/work/

ENTRYPOINT ["/bin/sh"]
