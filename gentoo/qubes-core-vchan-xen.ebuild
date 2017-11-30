# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

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

src_compile() {
	( cd u2mfn; emake )
	( cd vchan; emake -f Makefile.linux )
}

src_install() {
	install -D -m 0644 u2mfn/u2mfnlib.h "${D}"usr/include/u2mfnlib.h
	install -D -m 0644 u2mfn/u2mfn-kernel.h "${D}"usr/include/u2mfn-kernel.h
    install -D u2mfn/libu2mfn.so "${D}"usr/lib/libu2mfn.so.0

    install -D -m 0644 vchan/libvchan.h "${D}"usr/include/libvchan.h
	install -D vchan/libvchan.so "${D}"usr/lib/libvchan.so.0
}
