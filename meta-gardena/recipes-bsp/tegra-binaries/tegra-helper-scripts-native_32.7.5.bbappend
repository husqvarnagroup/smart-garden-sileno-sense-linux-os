
FILESEXTRAPATHS:prepend := "${THISDIR}/tegra-helper-scripts:"

SRC_URI += " \
    file://dofwup.sh \
    file://tegra210-flash-helper.sh \
"

S = "${WORKDIR}"

do_install:append() {
    install -m 0755 ${S}/dofwup.sh ${D}${bindir}/tegra210-flash/dofwup.sh
    install -m 0755 ${S}/tegra210-flash-helper.sh ${D}${bindir}/tegra210-flash/tegra210-flash-helper.sh
}
