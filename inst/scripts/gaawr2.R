create_gaawr2 <- function()
{
  library(usethis)
  create_package("gaawr2")
  use_mit_license()
  use_github_action("pkgdown", save_as = "R-CMD-check.yaml", ref = NULL, ignore = TRUE, open = FALSE)
  use_logo("pkgdown/logo.png")
# Image in README.Rmd
# <img src="man/figures/logo.png" align="right" height="86" alt="gaawr2 website" />
  library(pkgdown)
# favicons
  build_favicons(overwrite=TRUE)
}
