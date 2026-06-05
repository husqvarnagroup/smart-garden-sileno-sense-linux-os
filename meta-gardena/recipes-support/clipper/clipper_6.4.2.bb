DESRIPTION = "The Clipper library performs line & polygon clipping - intersection, union, difference & exclusive-or, and line & polygon offsetting"

LICENSE = "BSL-1.0"
LIC_FILES_CHKSUM = "file://../License.txt;md5=8e4ed4217fa0e1ebecd6214c4fd33577"

SRC_URI = "https://sourceforge.net/projects/polyclipping/files/clipper_ver6.4.2.zip"

SRC_URI[md5sum] = "100b4ec56c5308bac2d10f3966e35e11"
SRC_URI[sha256sum] = "a14320d82194807c4480ce59c98aa71cd4175a5156645c4e2b3edd330b930627"

inherit cmake

S = "${WORKDIR}/cpp"

