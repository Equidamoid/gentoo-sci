# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake fortran-2
CMAKE_BUILD_TYPE=MMG
FORTRAN_NEED_OPENMP=1

DESCRIPTION="bidimensional and tridimensional remesher"
HOMEPAGE="https://www.mmgtools.org/"

COMMIT=d422182c8118124b15aba1b1f2e6fb38e85fd6ba
SRC_URI="https://github.com/MmgTools/mmg/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/${PN}-${COMMIT}

LICENSE="GPL-3 LGPL-3"
KEYWORDS="~amd64"
SLOT="0"
IUSE="scotch vtk"

DEPEND="
	scotch? ( sci-libs/scotch )
	vtk? ( sci-libs/vtk )
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-doc/doxygen
"

src_configure() {
	local mycmakeargs=(
		-DUSE_VTK=$(usex vtk)
		-DUSE_SCOTCH=$(usex scotch)
		-DBUILD_SHARED_LIBS=ON
		-DLIBMMG2D_SHARED=ON
		-DLIBMMGS_SHARED=ON
		-DLIBMMG3D_SHARED=ON
	)
	cmake_src_configure
}

# no tests present
