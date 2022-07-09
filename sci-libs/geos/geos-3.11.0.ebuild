# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Geometry engine library for Geographic Information Systems"
HOMEPAGE="https://trac.osgeo.org/geos/"
SRC_URI="https://download.osgeo.org/geos/geos-3.11.0.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="doc test"
RESTRICT="!test? ( test )"

BDEPEND="doc? ( app-doc/doxygen )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOCUMENTATION=$(usex doc)
		-DBUILD_TESTING=$(usex test)
		-DUSE_CCACHE=OFF

		# bug #709368
		$(usex arm '-DDISABLE_GEOS_INLINE=ON' '')
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	use doc && cmake_src_compile docs
}

src_install() {
	cmake_src_install

	if use doc ; then
		HTML_DOCS=( "${BUILD_DIR}"/doc/doxygen_docs/html/. )
		einstalldocs
	fi
}