TERMUX_PKG_HOMEPAGE=https://github.com/KhronosGroup/Vulkan-Loader
TERMUX_PKG_DESCRIPTION="Vulkan Loader"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.3.265"
TERMUX_PKG_SRCURL=https://github.com/KhronosGroup/Vulkan-Loader/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=fffca4a5e6daf3bbe18585f96bf7cad8cf173ebf3fa4d00b755108bd0b129bd8
TERMUX_PKG_BUILD_DEPENDS="vulkan-headers (=${TERMUX_PKG_VERSION}), libx11, libxcb, libxrandr"
TERMUX_PKG_CONFLICTS="vulkan-loader-android"
TERMUX_PKG_PROVIDES="vulkan-loader-android"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DVULKAN_HEADERS_INSTALL_DIR=$TERMUX_PREFIX
-DBUILD_TESTS=OFF
-DENABLE_WERROR=OFF
"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE="newest-tag"

termux_step_pre_configure() {
	CPPFLAGS+=" -Wno-typedef-redefinition"
}

termux_step_post_make_install() {
	# Sanity check
	echo "INFO: ========== vulkan.pc =========="
	cat "$TERMUX_PREFIX/lib/pkgconfig/vulkan.pc"
	echo "INFO: ========== vulkan.pc =========="

	# Lots of apps will search libvulkan.so.1
	if [ ! -e $TERMUX_PREFIX/lib/libvulkan.so.1 ]; then
		ln -sfr $TERMUX_PREFIX/lib/libvulkan.so{,.1}
	fi
}
