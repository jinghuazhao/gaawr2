if (!requireNamespace("httr", quietly = TRUE)) install.packages("bibtex")
if (!requireNamespace("httr", quietly = TRUE)) install.packages("httr")
if (!requireNamespace("XML", quietly = TRUE)) install.packages("XML")

library(bibtex)
library(httr)
library(XML)

# Function to check URL status
check_url_status <- function(url) {
  response <- tryCatch(HEAD(url), error = function(e) NULL)
  if (!is.null(response) && status_code(response) == 200) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# Function to check URL status in a BibTeX file
check_bib_url_status <- function(bib_file) {
  bib <- read.bib(bib_file)
  for (i in 1:length(bib)) {
    if ("url" %in% names(bib[[i]])) {
      url <- bib[[i]]$url
      if (!check_url_status(url)) {
        bib[[i]]$url <- "URL not available"
      }
    }
  }
  return(bib)
}

# Function to check and replace URLs in the CSL file
namespace <- c(csl = "http://purl.org/net/xbiblio/csl")
check_csl_urls <- function(csl_file_path) {
  csl_doc <- xmlParse(csl_file_path)
  link_nodes <- xpathSApply(csl_doc, "//csl:link", xmlGetAttr, "href", namespaces = namespace)
  for (i in seq_along(link_nodes)) {
    url <- link_nodes[i]
    if (!check_url_status(url)) {
      link_nodes[i] <- "URL not available"
    }
  }
  for (i in 1:length(link_nodes)) {
    xpathApply(csl_doc, sprintf("//link[@href='%s']", link_nodes[i]), function(node) {
      xmlAttrs(node)["href"] <- link_nodes[i]
    })
  }
  csl_doc
}

test_url <- function()
{
# Check URLs in the .bib file
  bib_file <- system.file("REFERENCES.bib",package="gaawr2")
  updated_bib <- check_bib_url_status(bib_file)
  write.bib(updated_bib, file = "REFERENCES_updated.bib")

# Run URL check for CSL file
  csl_file <- system.file("csl","nature-genetics.csl",package="gaawr2")
  csl <- "nature-genetics.csl"
  check_csl_urls(csl_file)
}
