FROM debian:buster-slim

ARG GOOGLETEST_URL="https://github.com/google/googletest.git"
ARG GOOGLETEST_TAG="release-1.10.0"

WORKDIR /root

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    bash \
    cmake \
    make \
    git \
    g++-7 \
    python3-distutils \
    libncurses5-dev \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 10
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 10

RUN git config --global http.sslVerify false

RUN git clone "${GOOGLETEST_URL}"  --branch ${GOOGLETEST_TAG} --depth 1 \
    && cd googletest/ \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j 8 \
    && cd lib \
    && cp * /usr/local/lib/ \
    && cd .. \
    && cd .. \
    && cd googletest/include/ \
    && cp -r * /usr/local/include/ \
    && cd ../.. \
    && cd googlemock/include/ \
    && cp -r * /usr/local/include/ \
    && cd ../../.. \
    && rm -rf googletest
