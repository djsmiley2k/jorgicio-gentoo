# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils eutils versionator

MY_BR=$(get_version_component_range 1-2)

DESCRIPTION="Network File Transfer Application"
HOMEPAGE="http://nitroshare.net"
SRC_URI="https://launchpad.net/nitroshare/${MY_BR}/${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="appindicator"

DEPEND="dev-qt/qtcore:5
		dev-qt/qtsvg:5
		dev-qt/qtnetwork:5
		x11-libs/libnotify"

RDEPEND="${DEPEND}
		appindicator? (
			x11-libs/gtk+:2
			dev-libs/libappindicator:2
		)"

src_configure(){
	local myeqmakeargs=(
		${PN}.pro
		PREFIX="${EPREFIX}/usr"
		DESKTOPDIR="${EPREFIX}/usr/share/applications"
		ICONDIR="${EPREFIX}/usr/share/pixmaps"
	)
	eqmake5 ${myeqmakeargs[@]}
}

src_install(){
	emake INSTALL_ROOT="${D}" install
}
