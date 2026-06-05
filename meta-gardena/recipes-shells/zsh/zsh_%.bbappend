
RPROVIDES:${PN} += "/bin/bash"

pkg_postinst:${PN}:append () {
    ln -sf "/bin/zsh" $D${base_bindir}/bash
}

