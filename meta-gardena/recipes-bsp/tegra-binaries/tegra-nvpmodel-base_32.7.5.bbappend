
FILESEXTRAPATHS:prepend := "${THISDIR}/tegra-nvpmodel-base:"
MY_DIR := "${THISDIR}"

do_configure:prepend(){
    cp ${MY_DIR}/tegra-nvpmodel-base/nvpmodel_5w.conf ${B}
} 

do_install:append() {
    install -m 0644 ${B}/nvpmodel_5w.conf ${D}${sysconfdir}/nvpmodel.conf
}

