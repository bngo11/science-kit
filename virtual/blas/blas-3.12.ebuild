# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Virtual for FORTRAN 77 BLAS implementation"
SLOT="0"
KEYWORDS="*"

RDEPEND="|| (
		>=sci-libs/blas-reference-3.12
		>=sci-libs/mkl-9.1.023
	)"
