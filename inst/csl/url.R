if (!requireNamespace("httr", quietly = TRUE)) install.packages("bibtex")
if (!requireNamespace("httr", quietly = TRUE)) install.packages("httr")
if (!requireNamespace("XML", quietly = TRUE)) install.packages("XML")

library(bibtex)
library(httr)
library(XML)

# to check URL status
check_url_status <- function(url) {
  response <- tryCatch(httr::HEAD(url), error = function(e) NULL)
  if (!is.null(response) && httr::status_code(response) == 200) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# to check URL status in a BibTeX file
check_bib_url_status <- function(bib_file) {
  bib <- bibtex::read.bib(bib_file)
  for (i in seq_along(bib)) {
    if ("url" %in% names(bib[[i]])) {
      url <- bib[[i]]$url
      if (!check_url_status(url)) {
        bib[[i]]$url <- "URL not available"
      }
    }
  }
  return(bib)
}

# to check and replace URLs in the CSL file
namespace <- c(csl = "http://purl.org/net/xbiblio/csl")
check_csl_urls <- function(csl_file_path) {
  csl_doc <- XML::xmlParse(csl_file_path)
  link_nodes <- XML::xpathSApply(csl_doc, "//csl:link", XML::xmlGetAttr, "href", namespaces = namespace)
  for (i in seq_along(link_nodes)) {
    href <- link_nodes[i]
    if (!check_url_status(href)) {
      xpath_query <- paste("//csl:link[position()=", i, "]", sep = "")
      XML::xpathSApply(csl_doc, xpath_query, function(node) {
        XML::xmlAttrs(node)["href"] <- "URL not available"
      },namespaces = namespace)
    }
  }
  csl_doc
}

test_url <- function()
{
# Check URLs in the .bib file
  bib_file <- system.file("REFERENCES.bib",package="gaawr2")
  bib_updated <- check_bib_url_status(bib_file)
  bibtex::write.bib(bib_updated, file = "REFERENCES_updated.bib")

# Run URL check for CSL file
  csl_file <- system.file("csl","nature-genetics.csl",package="gaawr2")
  check_csl_urls(csl_file)
}
