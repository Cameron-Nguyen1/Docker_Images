FROM r-base:4.3.3

RUN apt-get update \
    && Rscript -e "install.packages(c('optparse','stringr'))" \
    && mkdir -p /usr/local/src/ \
    && mkdir -p /usr/local/work/  

COPY InhibitionCalculation_NoGraphs.r /usr/local/src/
WORKDIR /usr/local/work/

ENTRYPOINT ["/bin/sh"]

