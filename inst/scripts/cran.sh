#!/usr/bin/env bash

set -e
src="$HOME/gaawr2"
dst="$HOME/R/gaawr2"
log_file="$HOME/work/gaawr2_copy.log"

remove_destination() {
  if [ -d "$dst" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Removing existing destination directory: $dst" | tee -a "$log_file"
    rm -rf "$dst"
  elif [ -e "$dst" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Removing existing file at destination: $dst" | tee -a "$log_file"
    rm -f "$dst"
  fi
}
{
  echo "----------------------------------------"
  echo "Copy Operation Started: $(date '+%Y-%m-%d %H:%M:%S')"
  remove_destination
  echo "Creating destination directory: $dst" | tee -a "$log_file"
  mkdir -p "$dst"
  echo "Changing to source directory: $src" | tee -a "$log_file"
  cd "$src" || { echo "Error: Source directory not found: $src"; exit 1; }
  echo "Copying files excluding 'docs', 'pkgdown', and all hidden files/directories" | tee -a "$log_file"
  rsync -av --exclude='docs/' --exclude='pkgdown/' --exclude='.*' --exclude='*/.*' --exclude='README.Rmd' --exclude='LICENSE.md' ./ "$dst/"
  echo "Copy Operation Completed Successfully: $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$log_file"
} >> "$log_file" 2>&1

echo "Files copied successfully from $src to $dst. Check the log file at $log_file for details."

module load ceuadmin/R
module load gcc/11.3.0/gcc/4zpip55j
echo $R_LIBS

cd ~/R
export version=$(awk -F': *' '/^Version:/{print $2}' "$src/DESCRIPTION")
pkg="gaawr2"

echo "Step 1: Build package with vignettes"
R CMD build --compact-vignettes=both "$dst"

echo "Step 2: Install package to generate doc/"
R CMD INSTALL --build ${pkg}_${version}.tar.gz

echo "Step 3: Copy built vignettes into inst/doc"
mkdir -p "$dst/inst/doc"
cp -r ~/R/${pkg}/doc/* "$dst/inst/doc/" 2>/dev/null || true

echo "Step 4: Remove vignette sources for CRAN version"
rm -rf "$dst/vignettes"
sed -i '/^VignetteBuilder:/d' "$dst/DESCRIPTION"

echo "Step 5: Build CRAN submission tarball"
R CMD build --md5 --resave-data "$dst"

echo "Step 6: Check package"
R CMD check --as-cran ${pkg}_${version}.tar.gz
