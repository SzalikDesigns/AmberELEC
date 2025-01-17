# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2021 AmberELEC (https://github.com/AmberELEC)

PKG_NAME="es-theme-art-book-next"
PKG_REV="1"
PKG_VERSION="e5943ba1009d954d24f4a3c711a891c7c2f57c6d"
PKG_ARCH="any"
PKG_LICENSE="CUSTOM"
PKG_SITE="https://github.com/anthonycaccese/es-theme-art-book-next"
PKG_URL="$PKG_SITE.git"
PKG_SHORTDESC="ArtBook Next"
PKG_LONGDESC="Art Book Next - AmberELEC default theme"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
    mkdir -p $INSTALL/usr/config/emulationstation/themes/$PKG_NAME
    cp -rf * $INSTALL/usr/config/emulationstation/themes/$PKG_NAME

    RESOLUTION=""
    if [[ "$DEVICE" == "RG552" ]]; then
      RESOLUTION="1920x1152"
    elif [[ "$DEVICE" == "RG351P" ]]; then
      RESOLUTION="480x320"
    elif [[ "$DEVICE" == "RG351V" || "$DEVICE" == "RG351MP" ]]; then
      RESOLUTION="640x480"
    fi


}
