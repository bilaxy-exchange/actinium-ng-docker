FROM ubuntu:xenial

RUN apt-get update \
&& apt-get -y upgrade \
&& apt-get -y install libboost-all-dev libdb4.8 libdb4.8++ libssl1.0.0 libcap-dev libseccomp-dev \
&& apt-get -y install git build-essential libtool autotools-dev automake \
&& add-apt-repository ppa:bitcoin/bitcoin \
&& apt-get update \
&& apt-get -y install libdb4.8-dev libdb4.8++-dev unzip

ENV GIT_COIN_URL https://github.com/Actinium-project/Actinium-ng.git
ENV GIT_COIN_NAME actinium-ng

RUN	git clone $GIT_COIN_URL $GIT_COIN_NAME \
&& cd $GIT_COIN_NAME \
&& git checkout master \
&& chmod +x autogen.sh \
&& chmod +x share/genbuild.sh \
&& chmod +x src/leveldb/build_detect_platform \
&& ./autogen.sh && ./configure --disable-shared --disable-tests --disable-bench --without-gui LIBS="-lcap -lseccomp" \
&& make \
&& make install \
&& cd / && rm -rf /$GIT_COIN_NAME \

ENV HOME /root

RUN mkdir .actinium
RUN cp Actinium.conf .actinium

#rpc and mn port
EXPOSE 5335 4334

CMD Actiniumd