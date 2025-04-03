# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib multibuild

DESCRIPTION="Video game music file emulators"
HOMEPAGE="https://github.com/libgme/game-music-emu"
SRC_URI="https://github.com/libgme/game-music-emu/releases/download/${PV}/libgme-${PV}-src.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/libgme-${PV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~mips ~ppc ~ppc64 ~riscv ~x86"
IUSE="test +zlib"
RESTRICT="!test? ( test )"

BDEPEND="test? ( sys-process/parallel )"
DEPEND="
	zlib? ( sys-libs/zlib )
"
RDEPEND="${DEPEND}"

DOCS=( changes.txt design.txt gme.txt readme.txt )

src_configure() {
	local mycmakeargs=(
		-DENABLE_UBSAN=off # disabled so that if gcc[-sanitize] it does not fail to compile
		-DGME_ZLIB=$(usex zlib on off)
	)
	cmake-multilib_src_configure
}

multilib_src_test() {
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${BUILD_DIR}/gme" \
		emake -C "${S}/test" test \
		LIBGME_NEW_PATH="${BUILD_DIR}/gme/libgme.so" \
		CXXFLAGS="${CXXFLAGS}" LIBRARIES="${BUILD_DIR}/gme"
}
