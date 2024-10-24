# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg



RESTRICT="mirror strip preserve-libs"
# TODO
# * use dict from tree, linguas
# * do src_test (use junit from tree?)


DESCRIPTION="IDE for the R language"
HOMEPAGE="
	http://www.rstudio.org
	https://github.com/rstudio/rstudio/"
SRC_URI="https://download1.rstudio.org/desktop/bionic/amd64/rstudio-2022.02.0-443-amd64-debian.tar.gz -> rstudio-2022.02.0.443_x86_64.pkg.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""


RDEPEND="
	app-text/pandoc
	dev-java/aopalliance:1
	dev-java/gin:2.1
	dev-java/javax-inject
	=dev-java/validation-api-1.0*:1.0[source]
	dev-haskell/pandoc-citeproc
	dev-lang/R[cairo]
	dev-libs/boost:=
    dev-cpp/yaml-cpp
	>=dev-libs/mathjax-2.7.4
	sys-apps/util-linux
	sys-devel/clang:*
	sys-libs/zlib
    dev-db/soci[postgres,sqlite,c++11]
	>=virtual/jre-1.8:=
	x11-libs/pango
	|| ( dev-libs/openssl:0= 
	    dev-libs/libressl:0=
    )"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_prepare() {
	eapply_user
}

src_install() {
    mkdir -p "${D}/opt/"
	cp -Rp "${S}/"* "${D}/opt/rstudio"

	mkdir -p "${D}/usr/share/applications"
	cp "${FILESDIR}/rstudio-bin.desktop" "${D}/usr/share/applications/rstudio-bin.desktop"

	dosym ../../opt/rstudio/bin/rstudio /usr/bin/rstudio-bin
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}