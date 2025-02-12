library(httr)
library(jsonlite)
library(knitr)
library(kableExtra)

gene_id <- "ENSG00000164308"
query_string = "
  query target($ensemblId: String!){
    target(ensemblId: $ensemblId){
      id
      approvedSymbol
      biotype
      geneticConstraint {
        constraintType
        exp
        obs
        score
        oe
        oeLower
        oeUpper
      }
      tractability {
        label
        modality
        value
      }
    }
  }
"
base_url <- "https://api.platform.opentargets.org/api/v4/graphql"
variables <- list("ensemblId" = gene_id)
post_body <- list(query = query_string, variables = variables)
r <- httr::POST(url=base_url, body=post_body, encode='json')
data <- iconv(r, "", "ASCII")
content <- jsonlite::fromJSON(data)
target <- content$data$target
scalar_fields <- data.frame(
  Field = c("ID", "Approved Symbol", "Biotype"),
  Value = c(target$id, target$approvedSymbol, target$biotype)
)
tractability_data <- target$tractability
kableExtra::kbl(scalar_fields, caption = "Basic Information") %>%
  kableExtra::kable_styling(bootstrap_options = c("striped", "hover"))
kableExtra::kbl(target$geneticConstraint, caption = "Genetic Constraint Metrics") %>%
  kableExtra::kable_styling(bootstrap_options = c("striped", "hover"))
kableExtra::kbl(tractability_data, caption = "Tractability Information") %>%
  kableExtra::kable_styling(bootstrap_options = c("striped", "hover"), full_width = FALSE)
