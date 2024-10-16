# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Geometry engine library for Geographic Information Systems"
HOMEPAGE="http://trac.osgeo.org/geos/"
SRC_URI=https://download.osgeo.org/geos//geos-3.9.2.tar.bz2

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="doc ruby static-libs"

RDEPEND="
	ruby? ( dev-lang/ruby:* )
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	ruby? ( dev-lang/swig:0 )
"

PATCHES=( )

RESTRICT="test"


src_prepare() {
	default
	echo "#!${EPREFIX}/bin/bash" > py-compile
}

src_configure() {
	econf \
		--disable-python \
		$(use_enable ruby) \
		$(use_enable static-libs static)
}

src_compile() {
	default
	use doc && emake -C "${S}/doc" doxygen-html
}

src_install() {
	use doc && HTML_DOCS=( doc/doxygen_docs/html/. )
	default

	find "${D}" -name '*.la' -delete || die
}