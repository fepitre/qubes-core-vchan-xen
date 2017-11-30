# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Frédéric Pierret <frederic.epitre@orange.fr>

EAPI=6

inherit git-r3 eutils multilib

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}

KEYWORDS="amd64"
EGIT_REPO_URI="https://github.com/QubesOS/qubes-core-vchan-xen.git"
EGIT_COMMIT="v${PV}"
DESCRIPTION="QubesOS libvchan cross-domain communication library"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPLv2"

SLOT="0"
IUSE=""

DEPEND="app-emulation/qubes-vmm-xen"
RDEPEND=""
PDEPEND=""

src_prepare() {
    einfo "Apply patch set"
    EPATCH_SUFFIX="patch" \
    EPATCH_FORCE="yes" \
    EPATCH_OPTS="-p1" \
    epatch "${FILESDIR}"

    default
}

src_compile() {
    ( cd u2mfn; emake )
    ( cd vchan; emake -f Makefile.linux )
}

src_install() {
    install -D -m 0644 vchan/libvchan.h "${D}"/usr/include/libvchan.h
    install -D -m 0644 u2mfn/u2mfnlib.h "${D}"/usr/include/u2mfnlib.h
    install -D -m 0644 u2mfn/u2mfn-kernel.h "${D}"/usr/include/u2mfn-kernel.h
    install -D -m 0644 vchan/vchan-xen.pc "${D}"/usr/$(get_libdir)/pkgconfig/vchan-xen.pc
    
    install -D vchan/libvchan-xen.so "${D}"/usr/$(get_libdir)/libvchan-xen.so
    install -D u2mfn/libu2mfn.so "${D}"/usr/$(get_libdir)/libu2mfn.so
}
