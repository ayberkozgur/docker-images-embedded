docker-images-embedded
======================

Docker images containing CI tools for embedded development.

Images
------

- `images/stm32-ci`: CI image for building and testing embedded STM32 code. Contains:
  - gcc-arm-none-eabi-7-2018-q2-update
  - CMSIS core v5.4.0
  - CMSIS device F7 v1.2.5
  - CMSIS device F1 v4.3.2
  - stm32f7xx HAL driver v1.2.8
  - stm32f1xx HAL driver v1.1.7
  - STM32Cube F7 package v1.16.0
  - cmake toolchain file at https://github.com/ayberkozgur/arm-cmake.git
  - gtest release-1.10.0 (built from source)

- `images/uavcan-ci`: More barebone CI image for building and testing vendor UAVCAN types. Contains:
  - gcc-arm-none-eabi-7-2018-q2-update
  - gtest release-1.10.0 (built from source)

Build
-----

Run `ci/build.sh`.

CI/CD
-----

Github actions should automatically build and push the images to Dockerhub, no need to configure anything special.
