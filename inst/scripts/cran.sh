#!/usr/bin/env bash

set -euo pipefail
. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl ceuadmin/R mono/5.0.1.1 texlive

export TMPDIR=/rds/user/jhz22/hpc-work/work
export src="$HOME/gaawr2"
export dst="$HOME/R/gaawr2"
export log="$HOME/R/gaawr2_cran.log"

exec > >(tee -a "$log") 2>&1
echo "=== CRAN pipeline start $(date) on $(hostname) ==="

rm -rf "$dst"
mkdir -p "$dst"
cd "$src"
Rscript -e "devtools::document()"
rsync -a --delete \
  --exclude='docs/' --exclude='pkgdown/' \
  --exclude='README.Rmd' --exclude='LICENSE.md' \
  --exclude='.*' \
  "$src/" "$dst/"

module load ceuadmin/R
module load gcc/11.2.0/gcc/rjvgspag
export PATH="/home/jhz22/R-devel/bin:$PATH"
export _R_CHECK_CRAN_INCOMING_=TRUE
export _R_CHECK_CRAN_INCOMING_REMOTE_=TRUE
export _R_CHECK_FORCE_SUGGESTS_=FALSE
export _R_CHECK_LIMIT_CORES_=TRUE
export MAKEFLAGS="-j$(nproc)"

cd ~/R
cp ~/gaawr2/vignettes/{gaawr2,web}.Rmd vignettes
Rscript -e 'cat(R.version.string,"\n");devtools::document("gaawr2")'
R CMD INSTALL gaawr2
Rscript -e 'rmarkdown::render("vignettes/gaawr2.Rmd",
            output_file="gaawr2.html", output_dir="vignettes", clean=TRUE, quiet=TRUE);
            knitr::purl("vignettes/gaawr2.Rmd", output="vignettes/gaawr2.R", documentation=0)'
Rscript -e 'rmarkdown::render("vignettes/web.Rmd",
            output_file="web.html", output_dir="vignettes", clean=TRUE, quiet=TRUE);
            knitr::purl("vignettes/web.Rmd", output="vignettes/web.R", documentation=0)'
cp ~/R/vignettes/gaawr2_cran.Rmd $dst/vignettes/gaawr2.Rmd
cp ~/R/vignettes/web_cran.Rmd $dst/vignettes/web.Rmd
find vignettes -maxdepth 1 -type f \( -name '*.png' -o -name '10081*' \) ! -name 'IL-12B_mhtplot.trunc.png' -delete
find vignettes -type d -name "gaawr2" -exec rm -rf {} +
ver=$(awk '/^Version:/ {print $2}' "$dst/DESCRIPTION")
pkg="gaawr2_${ver}.tar.gz"
R CMD build --resave-data --compact-vignettes=both "$dst"
_R_CHECK_DEPENDS_ONLY_=true R CMD check --no-manual "$pkg"
R CMD check --as-cran --run-donttest "$pkg"
