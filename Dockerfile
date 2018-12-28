FROM ubuntu:bionic
# prepare packages
RUN apt-get update \
&& apt-get -y upgrade \
&& export DEBIAN_FRONTEND=noninteractive \
&& apt-get -y install libboost-system1.65.1 libboost-filesystem1.65.1 libboost-program-options1.65.1 \
libboost-thread1.65.1 libboost-chrono1.65.1 libdb4.8 libdb4.8++ libssl1.0.0 unzip \
libevent-2.1-6 libevent-pthreads-2.1-6 software-properties-common \
git build-essential libtool autotools-dev automake \
&& add-apt-repository ppa:bitcoin/bitcoin \
&& apt-get update \
&& apt-get -y install libdb4.8-dev libdb4.8++-dev unzip \
&& apt-get -y install wget libzmq5 libminiupnpc10 libcap2
# prepare git
ENV GIT_COIN_URL https://github.com/Actinium-project/Actinium-ng.git
ENV GIT_COIN_NAME actinium-ng
# clone & compile
RUN	git clone $GIT_COIN_URL $GIT_COIN_NAME \
&& cd $GIT_COIN_NAME \
&& git checkout master \
&& chmod +x autogen.sh \
&& chmod +x share/genbuild.sh \
&& chmod +x src/leveldb/build_detect_platform \
&& ./autogen.sh && ./configure --disable-shared --disable-tests --disable-bench --without-gui \
&& make \
&& make install \
&& cd / && rm -rf /$GIT_COIN_NAME \
# switch to home dir
ENV HOME /root
RUN mkdir .actinium
RUN cp Actinium.conf .actinium
#rpc and mn port
EXPOSE 5335 4334
# run daemon
CMD Actiniumd