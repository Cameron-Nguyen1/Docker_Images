FROM r-base:4.3.1

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev

RUN Rscript -e "install.packages('Racmacs', repos='http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/Archive/ggplot2/ggplot2_3.4.4.tar.gz', repos=NULL, type='source')"
RUN Rscript -e "install.packages(c('rjson','httr', 'jsonlite', 'logger', 'remotes','stringr','reshape2','paletteer','optparse'))"

RUN mkdir -p /usr/local/src/cartography
RUN mkdir -p /usr/local/work/

WORKDIR /usr/local/work/

COPY cartography.r /usr/local/src/cartography/cartography.r

ENTRYPOINT ["/bin/Rscript","/usr/local/src/cartography/cartography.r"]