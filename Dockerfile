FROM ubuntu:20.04
RUN mkdir -p /gAnswer
WORKDIR /gAnswer
VOLUME . /gAnswer

RUN apt update \
    && apt autoclean \
    && apt install -y tmux vim wget git \
    && apt install -y python3 python3-pip \
    && apt install -y openjdk-8-jdk openjdk-8-jre \
    && apt install -y upgrade

RUN pip install -y gdown

RUN mkdir -p /gAnswer/data \
    && cd /gAnswer/data \
    && gdown https://drive.google.com/u/0/uc?id=1hmqaftrTo0_qQNRApCuxFXaBx7SosNVy \
    && unrar x ./DBpedia2016.rar ./ \
    && rm ./DBpedia2016.rar \
    && cd /gAnswer

RUN gdown https://drive.google.com/u/0/uc?id=1tEsi4pBOBHd2gmwVgIOgt-ypJZQH9G3S \
    && unzip ganswer_lib.zip \
    && mv ganswer_lib lib \
    && rm ganswer_lib.zip

RUN chmod +rx ./run_http.sh

EXPOSE 9999
EXPOSE 9000

CMD ["./run_http.sh"]