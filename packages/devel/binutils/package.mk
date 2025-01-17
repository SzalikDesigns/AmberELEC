# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="binutils"
PKG_VERSION="2.35.1"
PKG_SHA256="3ced91db9bf01182b7e420eab68039f2083aed0a214c0424e257eae3ddee8607"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/binutils/"
PKG_URL="http://ftp.gnu.org/gnu/binutils/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host bison:host flex:host linux:host"
PKG_DEPENDS_TARGET="toolchain zlib binutils:host"
PKG_LONGDESC="A GNU collection of binary utilities."

PKG_CONFIGURE_OPTS_HOST="--target=${TARGET_NAME} \
                         --with-sysroot=${SYSROOT_PREFIX} \
                         --with-lib-path=${SYSROOT_PREFIX}/lib:${SYSROOT_PREFIX}/usr/lib \
                         --without-ppl \
                         --without-cloog \
                         --disable-werror \
                         --disable-multilib \
                         --disable-libada \
                         --disable-libssp \
                         --enable-version-specific-runtime-libs \
                         --enable-plugins \
                         --enable-gold \
                         --enable-ld=default \
                         --enable-lto \
                         --disable-nls"

PKG_CONFIGURE_OPTS_TARGET="--target=${TARGET_NAME} \
                         --with-sysroot=${SYSROOT_PREFIX} \
                         --with-lib-path=${SYSROOT_PREFIX}/lib:${SYSROOT_PREFIX}/usr/lib \
                         --with-system-zlib \
                         --without-ppl \
                         --without-cloog \
                         --enable-static \
                         --disable-shared \
                         --disable-werror \
                         --disable-multilib \
                         --disable-libada \
                         --disable-libssp \
                         --disable-plugins \
                         --disable-gold \
                         --enable-ld \
                         --disable-lto \
                         --disable-nls"

pre_configure_host() {
  unset CPPFLAGS
  unset CFLAGS
  unset CXXFLAGS
  unset LDFLAGS
}

make_host() {
  make configure-host
  make
}

makeinstall_host() {
  cp -v ../include/libiberty.h ${SYSROOT_PREFIX}/usr/include
  make install
}

make_target() {
  make configure-host
  make -C libiberty
  make -C bfd
  make -C opcodes
  make -C binutils strings
  make -C libctf
  make -C ld
  make -C binutils objdump

}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib
    cp libiberty/libiberty.a ${SYSROOT_PREFIX}/usr/lib
  make DESTDIR="${SYSROOT_PREFIX}" -C bfd install
  make DESTDIR="${SYSROOT_PREFIX}" -C opcodes install

  mkdir -p ${INSTALL}/usr/bin
    cp binutils/strings ${INSTALL}/usr/bin
    cp ld/ld-new ${INSTALL}/usr/bin/ld
    cp binutils/objdump ${INSTALL}/usr/bin
}
