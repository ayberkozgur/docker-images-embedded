FROM debian:buster-slim

ARG TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2"
ARG CMSIS_CORE_URL="https://github.com/STMicroelectronics/cmsis_core.git"
ARG CMSIS_CORE_TAG="v5.4.0"
ARG CMSIS_DEVICE_F7_URL="https://github.com/STMicroelectronics/cmsis_device_f7.git"
ARG CMSIS_DEVICE_F7_TAG="v1.2.5"
ARG CMSIS_DEVICE_F1_URL="https://github.com/STMicroelectronics/cmsis_device_f1.git"
ARG CMSIS_DEVICE_F1_TAG="v4.3.2"
ARG STM32F7XX_HAL_DRIVER_URL="https://github.com/STMicroelectronics/stm32f7xx_hal_driver.git"
ARG STM32F7XX_HAL_DRIVER_TAG="v1.2.8"
ARG STM32F1XX_HAL_DRIVER_URL="https://github.com/STMicroelectronics/stm32f1xx_hal_driver.git"
ARG STM32F1XX_HAL_DRIVER_TAG="v1.1.7"
ARG CUBE_F7_URL="https://github.com/STMicroelectronics/STM32CubeF7.git"
ARG CUBE_F7_TAG="v1.16.0"
ARG CMAKE_TOOLCHAIN_FILE_URL="https://github.com/ayberkozgur/arm-cmake.git"
ARG GOOGLETEST_URL="https://github.com/google/googletest.git"
ARG GOOGLETEST_TAG="release-1.10.0"

WORKDIR /root
COPY ./scripts/* ./scripts/

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    bash \
    wget \
    bzip2 \
    cmake \
    make \
    git \
    g++-7 \
    gcovr \
    python3-distutils \
    rhash \
    xxd \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 10
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 10
RUN update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-7 10

RUN wget --no-check-certificate ${TOOLCHAIN_URL} \
    && export TOOLCHAIN_TARBALL=$(basename "${TOOLCHAIN_URL}") \
    && tar -xvf ${TOOLCHAIN_TARBALL} \
    && rm ${TOOLCHAIN_TARBALL} \
    && rm -rf /root/gcc-arm-none-eabi-7-2018-q2-update/share/doc
ENV TOOLCHAIN_PATH /root/gcc-arm-none-eabi-7-2018-q2-update

RUN git config --global http.sslVerify false

RUN scripts/git-sparse-checkout.sh /root/cmsis_core "${CMSIS_CORE_URL}" "${CMSIS_CORE_TAG}" Include/
ENV CMSIS_CORE_PATH /root/cmsis_core

RUN scripts/git-sparse-checkout.sh /root/cmsis_device_f7 "${CMSIS_DEVICE_F7_URL}" "${CMSIS_DEVICE_F7_TAG}" Include/
ENV CMSIS_DEVICE_F7_PATH /root/cmsis_device_f7

RUN scripts/git-sparse-checkout.sh /root/cmsis_device_f1 "${CMSIS_DEVICE_F1_URL}" "${CMSIS_DEVICE_F1_TAG}" Include/
ENV CMSIS_DEVICE_F1_PATH /root/cmsis_device_f1

RUN scripts/git-sparse-checkout.sh /root/stm32f7xx_hal_driver "${STM32F7XX_HAL_DRIVER_URL}" "${STM32F7XX_HAL_DRIVER_TAG}" Inc/ Src/
ENV STM32F7XX_HAL_DRIVER_PATH /root/stm32f7xx_hal_driver

RUN scripts/git-sparse-checkout.sh /root/stm32f1xx_hal_driver "${STM32F1XX_HAL_DRIVER_URL}" "${STM32F1XX_HAL_DRIVER_TAG}" Inc/ Src/
ENV STM32F1XX_HAL_DRIVER_PATH /root/stm32f1xx_hal_driver

RUN scripts/git-sparse-checkout.sh /root/STM32CubeF7 "${CUBE_F7_URL}" "${CUBE_F7_TAG}" Middlewares/Third_Party/FatFs/
ENV CUBE_F7_PATH /root/STM32CubeF7

RUN git clone "${CMAKE_TOOLCHAIN_FILE_URL}" \
    && rm -rf /root/arm-cmake/.git
ENV CMAKE_TOOLCHAIN_FILE /root/arm-cmake/arm-none-eabi.stm32.toolchain.cmake

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
