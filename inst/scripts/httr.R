library(httr)
library(jsonlite)

openai_token <- Sys.getenv("SUPERSECRET_OPENAI_TOKEN")
body <- list(
  model = "dall-e-3",
  prompt = "man in a classroom teaching physics, 18th century theme, clip-art style, print friendly",
  n = 1,
  size = "1024x1024"
)
response <- POST(
  url = "https://api.openai.com/v1/images/generations",
  httr::add_headers(
    "Content-Type" = "application/json",
    "Authorization" = paste("Bearer", openai_token)
  ),
  body = jsonlite::toJSON(body, auto_unbox = TRUE)
)

if (httr::status_code(response) == 200) {
  result <- httr::content(response, "parsed")
  print(result$data[[1]]$url)
} else {
  print(paste("Error:", httr::status_code(response)))
  print(httr::content(response, "text"))
}
