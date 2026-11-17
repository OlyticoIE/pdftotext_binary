#!/bin/zsh
set -euC -o pipefail

v=26.11.0

# Requires git cmake pkg-config freetype-devel fontconfig-devel
#
# Would be nicer to build in a container, but I can't be bothered.

if [[ -d poppler ]]; then
	(cd poppler && git checkout master && git pull)
else
	git clone https://gitlab.freedesktop.org/poppler/poppler.git
fi
cd poppler
git checkout poppler-$v
git apply <../static.patch ||:

mkdir -p build
cd build
NO_COLOR=1 cmake .. \
	-DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=release \
	-DENABLE_NSS3=OFF -DENABLE_GPGME=OFF -DENABLE_LIBTIFF=OFF -DENABLE_HARFBUZZ=OFF -DENABLE_LIBJPEG=OFF \
	-DENABLE_QT5=OFF -DBUILD_QT5_TESTS=OFF -DENABLE_QT6=OFF -DBUILD_QT6_TESTS=OFF -DENABLE_BOOST=OFF \
	-DENABLE_LIBOPENJPEG=OFF -DENABLE_LCMS=OFF -DENABLE_LIBCURL=OFF

cd utils
make -j8 ||: # Expected to fail as it adds -l[..].so

# Run pdftotext compile command with static libs
cmd=(
	c++
	-Wall -Wextra -Wpedantic -Wcast-align -Wformat-security -Wframe-larger-than=65536 -Wmissing-format-attribute
	-Wnon-virtual-dtor -Woverloaded-virtual -Wmissing-declarations -Wundef -Wzero-as-null-pointer-constant
	-Wshadow -Wweak-vtables -fno-exceptions -fno-common
	-D_DEFAULT_SOURCE -O2 -DNDEBUG

	CMakeFiles/pdftotext.dir/pdftotext.cc.o CMakeFiles/pdftotext.dir/printencodings.cc.o
	-o pdftotext

	libutils_common_lib.a -static ../libpoppler.a
	$(pkg-config --libs --static fontconfig freetype2)
)
$cmd

cp pdftotext ../../../bin/pdftotext_bin
gzip -f ../../../bin/pdftotext_bin
