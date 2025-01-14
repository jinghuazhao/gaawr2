#!/usr/bin/bash

Rscript -e '
      library(pkgdown)
      init_site()
      devtools::document()
      build_site()
  '
