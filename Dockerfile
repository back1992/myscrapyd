#
# Dockerfile for scrapyd
#

FROM debian:jessie
#FROM ubuntu
MAINTAINER danile <linmukong@icloud.com>
RUN mkdir /code
WORKDIR /code

ADD requirements.txt /code/
ADD . /code/
#RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf
RUN set -xe \
    && apt-key update \
    && apt-get update \
    && apt-get install -y autoconf \
                          build-essential \
                          curl \
                          git \
                          libffi-dev \
                          libssl-dev \
                          libtool \
                          libxml2 \
                          libxml2-dev \
                          libxslt1.1 \
                          libxslt1-dev \
                          python \
                          python-dev \
                          python-pip \
                          python-setuptools \
                          cython \
                          vim-tiny \
                          wget \
    && apt-get install -y libtiff5 \
                          libtiff5-dev \
                          libfreetype6-dev \
                          libjpeg62-turbo \
                          libjpeg62-turbo-dev \
#                          libjpeg-turbo8 \
#                          libjpeg-turbo8-dev \
                          liblcms2-2 \
                          liblcms2-dev \
                          libwebp5 \
                          libwebp-dev \
                          zlib1g \
                          zlib1g-dev \
                          libpq-dev \
                          postgresql \
                          postgresql-contrib \
                          postgresql-server-dev-all \
                          python-scipy \
                          python-numpy \
                          python-psycopg2 \
    && wget https://bootstrap.pypa.io/ez_setup.py -O - | python \
#    && curl -sSL https://bootstrap.pypa.io/get-pip.py | python \
#    && pip install git+https://github.com/scrapy/scrapy.git \
#                   git+https://github.com/scrapy/scrapyd.git \
#                   git+https://github.com/scrapy/scrapyd-client.git \
#                   git+https://github.com/scrapinghub/scrapy-splash.git \
#                   git+https://github.com/python-pillow/Pillow.git \
    && pip install pip -U \
                   setuptools -U \
                   scrapy \
                   scrapyd \
                   scrapyd-client \
                   scrapy-splash \
                   Pillow \
#    && pip install -r requirements.txt \
#    && curl -sSL https://github.com/scrapy/scrapy/raw/master/extras/scrapy_bash_completion -o /etc/bash_completion.d/scrapy_bash_completion \
#    && ADD ./scrapy_bash_completion /etc/bash_completion.d/ \
#    && echo 'source /etc/bash_completion.d/scrapy_bash_completion' >> /root/.bashrc \

    && apt-get purge -y --auto-remove autoconf \
                                      build-essential \
                                      libffi-dev \
                                      libssl-dev \
                                      libtool \
                                      libxml2-dev \
                                      libxslt1-dev \
                                      python-dev \
    && apt-get purge -y --auto-remove libtiff5-dev \
                                      libfreetype6-dev \
                                      libjpeg62-turbo-dev \
                                      liblcms2-dev \
                                      libwebp-dev \
                                      zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

COPY ./scrapyd.conf /etc/scrapyd/
VOLUME /etc/scrapyd/ /var/lib/scrapyd/
EXPOSE 6800

CMD ["scrapyd"]


#WORKDIR /code
ADD ./scrapy_bash_completion /etc/bash_completion.d/ \
RUN echo 'source /etc/bash_completion.d/scrapy_bash_completion' >> /root/.bashrc \
#RUN set -xe \
#    && apt-get update \
#    && apt-get install -y autoconf \
#                          build-essential \
#                          wget
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
    && tar -xzf ta-lib-0.4.0-src.tar.gz \
    && cd ta-lib/ \
    && ./configure --prefix=/usr \
    && make \
    && make install
RUN pip install -r requirements.txt


