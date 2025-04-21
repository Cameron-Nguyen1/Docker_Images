FROM debian:latest

#Download Java -> /usr/src/jdk-24.0.1/bin/java
#Download snpEff -> /usr/src/snpEff/snpEff.jar
#Clean up
RUN apt update && apt install samtools bcftools bowtie2 unzip -y \
&& mkdir -p /usr/local/work/ && cd /usr/local/work/ \
&& /usr/lib/apt/apt-helper download-file https://download.oracle.com/java/24/latest/jdk-24_linux-x64_bin.tar.gz /tmp/java.tar.gz && tar -xzf /tmp/java.tar.gz --directory /usr/src/ \
&& /usr/lib/apt/apt-helper download-file https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip /tmp/snpEff_latest_core.zip && unzip /tmp/snpEff_latest_core.zip -d /usr/src/ \
&& rm -r /tmp/*

COPY snpEff_db snpEff_info.json bt2.zip /usr/local/work/
RUN unzip /usr/local/work/bt2.zip -d /usr/local/work/

WORKDIR /usr/local/work/

ENTRYPOINT ["/bin/sh"]

#Example
#/usr/src/jdk-24.0.1/bin/java -jar /usr/src/snpEff/snpEff.jar -c ./snpEff_db/snpEff.config -v SARS2 ./Covid19Mutations.vcf > ./VCF_EX_ANN.vcf