# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=DONEILL
DIST_VERSION=0.201
inherit perl-module

DESCRIPTION="Tools to determine actual memory usage"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~s390 ~sparc"

BDEPEND="dev-perl/Module-Install"
