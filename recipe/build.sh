#! /usr/bin/bash
set -e

make dynamic FC="${FC}" FFLAGS="${FFLAGS}"
mv "libmpfun90${SHLIB_EXT}" "${PREFIX}/lib/"
mkdir -p "${PREFIX}/include/mpfun90"
mv *.mod "${PREFIX}/include/mpfun90/"
make clean
