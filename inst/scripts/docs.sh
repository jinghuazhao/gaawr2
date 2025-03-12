#!/usr/bin/bash

function setup()
{
Rscript -e '
  suppressMessages(library(pkgdown))
  {
    knitr::knit("README.Rmd")
    roxygen2::roxygenise()
    pkgdown::build_favicons(overwrite=TRUE)
    pkgdown::build_site()
  }
  pkgdown::build_site_github_pages()
# clean_site(); init_site(); build_home(); build_news(); build_articles(); build_reference(); build_search()
'
# devtools::build_rmd() is equivalent but limited, so knitr::knit/pandoc are better options.
# pandoc README.md --citeproc --mathjax -s --self-contained -o index.html
}

# setup

module load ceuadmin/R
Rscript -e '
# rmarkdown::render("pkgdown/index.Rmd", output_format = "md_document");
  knitr::knit("README.Rmd");devtools::document();pkgdown::build_site()
'

for d in gaawr2
do
    if [ -d vignettes/${d} ]; then
       rm -rf docs/articles/${d}
       mv vignettes/${d} docs/articles/
    fi
done

for f in .github .gitignore .Rbuildignore .Rinstignore $(ls)
do
  echo adding ${f}
  git add ${f}
  git commit -m "${f}"
done
git push --set-upstream origin main
du -h --exclude .git --exclude docs
