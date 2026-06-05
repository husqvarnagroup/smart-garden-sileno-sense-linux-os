
#EXTRA_OECMAKE:append = " -DBUILD_opencv_sfm=OFF"
#TODO: specify list of things we actually use
EXTRA_OECMAKE:append = " -DBUILD_LIST=core,imgproc,video,videoio,features2d,calib3d,cudev,cudafeatures2d,cudaimgproc,cudaoptflow \
                         -DJPEG_INCLUDE_DIR=${WORKDIR}/recipe-sysroot/usr/include/libjpeg-8b \
                         -DJPEG_LIBRARY=${WORKDIR}/recipe-sysroot/usr/lib/libnvjpeg.so"

PACKAGECONFIG:append = " libav"
PACKAGECONFIG:remove = " python3 samples tbb gphoto2 gtk gstreamer gapi"

DEPENDS:append = " tegra-mmapi tegra-libraries-cuda"

do_install:append() {
    ln -sf opencv4/opencv2 ${D}${includedir}/opencv2
}
