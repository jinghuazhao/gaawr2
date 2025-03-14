create_gaawr2 <- function()
{
  library(usethis)
  create_package("gaawr2")
  use_mit_license()
  use_github_action("pkgdown", save_as = "R-CMD-check.yaml", ref = NULL, ignore = TRUE, open = FALSE)
}
