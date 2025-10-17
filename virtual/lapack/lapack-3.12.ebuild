# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Virtual for Linear Algebra Package FORTRAN 77 (LAPACK) implementation"
SLOT="0"
KEYWORDS="*"

RDEPEND="|| (
		>=sci-libs/lapack-reference-3.12
		>=sci-libs/mkl-10
	)"
