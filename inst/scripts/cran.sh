#!/usr/bin/env bash

dst="$HOME/gaawr2"
ver=$(awk '/^Version:/ {print $2}' "$dst/DESCRIPTION")
pkg="gaawr2_${ver}.tar.gz"

module load ceuadmin/R
R CMD build --resave-data --compact-vignettes=both "$dst"
_R_CHECK_DEPENDS_ONLY_=true R CMD check --no-manual "$pkg"
R CMD INSTALL "$pkg"
R CMD check --as-cran --run-donttest "$pkg"
