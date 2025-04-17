FROM debian

RUN apt update && apt install samtools bcftools bowtie2 unzip -y
RUN mkdir -p /usr/local/work/

#Download Java -> /opt/java/jdk-24.0.1/bin/java
#RUN wget -O /opt/java.tar.gz https://download.oracle.com/java/24/latest/jdk-24_linux-x64_bin.tar.gz && tar xzf /opt/java.tar.gz
RUN /usr/lib/apt/apt-helper download-file https://download.oracle.com/java/24/latest/jdk-24_linux-x64_bin.tar.gz /opt/java.tar.gz && tar xzf /opt/java.tar.gz
#Download snpEff -> /opt/snpEff/snpEff.jar
#RUN wget -O /opt/snpEff_latest_core.zip https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip && unzip /opt/snpEff_latest_core.zip -d /opt/
RUN /usr/lib/apt/apt-helper download-file https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip /opt/snpEff_latest_core.zip && unzip /opt/snpEff_latest_core.zip -d /opt/
#Clean TARGZ
RUN rm /opt/*.tar.gz

#Add premade snpeff DB to work dir
COPY snpEff_db snpEff_info.json /usr/local/work/

WORKDIR /usr/local/work/

ENTRYPOINT ["/bin/sh"]

#Example
#/opt/java/jdk-24.0.1/bin/java -jar /opt/snpEff/snpEff.jar -c ./snpEff_db/snpEff.config -v SARS2 ./Covid19Mutations.vcf > ./VCF_EX_ANN.vcf