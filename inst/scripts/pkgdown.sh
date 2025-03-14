#!/usr/bin/bash

convert -density 300 logo.svg logo.png

Rscript -e '
      knitr::knit("README.Rmd")
      library(pkgdown)
    # init_site()
    # roxygen2::roxygenise()
      devtools::document()
      build_site()
  '
