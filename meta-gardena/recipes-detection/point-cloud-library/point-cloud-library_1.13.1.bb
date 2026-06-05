DESCRIPTION = "The Point Cloud Library (or PCL) is a large scale, open project for 2D/3D image and point cloud processing."
HOMEPAGE = "https://github.com/PointCloudLibrary/pcl"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=5b8a2a1aa14e6de44b4273134946a34c"

SRC_URI += "https://github.com/PointCloudLibrary/pcl/archive/pcl-${PV}.tar.gz \            
           "

SRC_URI[md5sum] = "b28011120e18d1d0d7dd8b30204874eb"
SRC_URI[sha256sum] = "8ab98a9db371d822de0859084a375a74bdc7f31c96d674147710cf4101b79621"

S = "${WORKDIR}/pcl-pcl-${PV}"

DEPENDS += "boost libeigen flann qhull"

inherit cmake

EXTRA_OECMAKE += "  -DWITH_QT=FALSE \
                    -DWITH_VTK=FALSE \
                    -DWITH_OPENGL=FALSE \
                    -DBUILD_geometry=ON \
					-DBUILD_io=OFF \
					-DBUILD_keypoints=OFF \
					-DBUILD_ml=ON \
					-DBUILD_recognition=OFF \
					-DBUILD_segmentation=ON \
					-DBUILD_stereo=OFF \
					-DBUILD_surface=ON \
					-DBUILD_tools=OFF \
					-DBUILD_tracking=OFF \
                 "
# Parallel builds will use too much memory and cause OOM kills
PARALLEL_MAKE = "-j 8"

FILES:${PN}-dev += "/usr/share/pcl-1.13/*"

INSANE_SKIP:${PN} += "useless-rpaths"

do_install:append() {
    ln -sf pcl-1.13/pcl ${D}${includedir}/pcl
}
