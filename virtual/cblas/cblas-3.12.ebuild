# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Virtual for BLAS C implementation"
SLOT="0"
KEYWORDS="*"

RDEPEND="|| (
		>=sci-libs/cblas-reference-3.12
		sci-libs/gsl[-cblas-external]
		>=sci-libs/mkl-9.1.023
	)"
