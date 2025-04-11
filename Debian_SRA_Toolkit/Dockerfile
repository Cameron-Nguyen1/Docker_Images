FROM debian

RUN apt update && apt install sra-toolkit -y

RUN mkdir -p /usr/local/work/
WORKDIR /usr/local/work/

ENTRYPOINT ["/bin/sh"]