library(httr)
library(bibtex)

# Function to check URL status in a BibTeX file
check_bib_url_status <- function(bib_file) {
  bib <- read.bib(bib_file)
  
  for (i in 1:length(bib)) {
    if ("url" %in% names(bib[[i]])) {
      url <- bib[[i]]$url
      if (!check_url_status(url)) {
        # If URL is invalid, replace with fallback message
        bib[[i]]$url <- "URL not available"
      }
    }
  }
  
  # Return modified .bib object
  return(bib)
}

# Check URLs in the .bib file
updated_bib <- check_bib_url_status("REFERENCES.bib")
write.bib(updated_bib, file = "updated_references.bib")
