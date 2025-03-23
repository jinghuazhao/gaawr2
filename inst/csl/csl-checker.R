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

# Function to check and replace URLs in the CSL file
check_csl_urls <- function(csl_file_path) {
  # Parse the CSL XML file
  csl_doc <- xmlParse(csl_file_path)
  
  # Extract all href attributes from <link> elements
  link_nodes <- xpathSApply(csl_doc, "//link/@href", xmlValue)
  
  # Check the status of each URL and update if needed
  for (i in 1:length(link_nodes)) {
    url <- link_nodes[i]
    if (!check_url_status(url)) {
      # Replace invalid URL with fallback message
      link_nodes[i] <- "URL not available"
    }
  }
  
  # Update the CSL document with modified URLs
  for (i in 1:length(link_nodes)) {
    xpathApply(csl_doc, sprintf("//link[@href='%s']", link_nodes[i]), function(node) {
      xmlAttrs(node)["href"] <- link_nodes[i]
    })
  }
  
  # Save the updated CSL file
  saveXML(csl_doc, file = csl_file_path)
}

# Run URL check for CSL file
check_csl_urls("nature-genetics.csl")
