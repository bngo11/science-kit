# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fortran-2 autotools

DESCRIPTION="Guile-based library for scientific simulations"
HOMEPAGE="http://ab-initio.mit.edu/libctl/"
SRC_URI="https://github.com/NanoComp/libctl/tarball/5a8155b4e1dbb0ec1a438e78bf0dae6f7f5d7f94 -> libctl-4.6.0-5a8155b.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="*"
IUSE="doc examples static-libs"

DEPEND="
	dev-scheme/guile
	sci-libs/nlopt"
RDEPEND="${DEPEND}"

S="${WORKDIR}/NanoComp-libctl-5a8155b"

src_install() {

	use doc && dohtml doc/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins "${AUTOTOOLS_BUILD_DIR}"/examples/{*.c,*.h,example.scm,Makefile}
		doins "${S}"/examples/{README,example.c,run.ctl}
	fi
}