#!/usr/bin/bash

function setup()
{
Rscript -e '
  suppressMessages(library(pkgdown))
  {
    knitr::knit("README.Rmd")
    roxygen2::roxygenise()
    pkgdown::build_site()
  }
  pkgdown::build_site_github_pages()
  usethis::use_github_action("pkgdown", save_as = "R-CMD-check.yaml", ref = NULL, ignore = TRUE, open = FALSE)
# clean_site(); init_site(); build_home(); build_news(); build_articles(); build_reference(); build_search()
'
# devtools::build_rmd() is equivalent but limited, so knitr::knit/pandoc are better options.
# pandoc README.md --citeproc --mathjax -s --self-contained -o index.html
}

setup

for f in .github $(ls)
do
  echo adding ${f}
  git add ${f}
  git commit -m "${f}"
done
git push --set-upstream origin main
du -h --exclude .git --exclude docs
