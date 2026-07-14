#! /usr/bin/bash
set -e

# Upstream Makefile's `dynamic` target hardcodes Linux's `-shared
# -Wl,-soname,...` and a literal `.so` output name; macOS needs
# `-dynamiclib` (no -soname equivalent) and SHLIB_EXT (.dylib), or the
# link step fails and the `mv` below can't find libmpfun90${SHLIB_EXT}.
if [ "$(uname)" = "Darwin" ]; then
  sed -i.bak "s/-shared -Wl,-soname,libmpfun90\.so/-dynamiclib/; s/libmpfun90\.so/libmpfun90${SHLIB_EXT}/g" Makefile
fi

make dynamic FC="${FC}" FFLAGS="${FFLAGS}"
mv "libmpfun90${SHLIB_EXT}" "${PREFIX}/lib/"
mkdir -p "${PREFIX}/include/mpfun90"
mv *.mod "${PREFIX}/include/mpfun90/"
make clean
