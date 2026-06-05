# GARDENA smart SILENO sense Linux OS

## Foreword

This repository exists purely to fulfil the FOSS license obligations related to
the GARDENA smart SILENO sense products. GARDENA will not accept contributions
to this product.

## Compiling the Software

### Obtaining the Source Code

The source code of this project is maintained with git.

```
git clone --recurse-submodules <repository>
cd smart-garden-sileno-sense-linux-os
```

Source code packages for all distributed versions can be found [here](https://opensource.smart.gardena.dev/mower/index.html).

## Prerequisites

* The Yocto build host packages need [to be installed](https://docs.yoctoproject.org/dev/ref-manual/system-requirements.html?highlight=build%20host%20package#required-packages-for-the-build-host)

## Build Instructions

```
./bbwrapper.sh image-gardena
./bbwrapper.sh image-gardena-top-layer
./bbwrapper.sh image-gardena-bottom-layer
```

TBD:
- How to build a flashable image

## Installing

Please be aware that any modification to your mower may permanently brick your
device and is not covered by warranty!

TBD:
- How to flash the image generated above
