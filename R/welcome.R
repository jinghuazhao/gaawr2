#' welcome Function
#'
#' This function prints a welcome message, saying number of times.
#'
#' @param n The number of times (>1 integer) to welcome the user.
#' @return Prints a welcome message to the console.
#' @examples
#' welcome(3)
#'
#' @export

welcome <- function(n) {
  if (missing(n)) {
    stop("Argument 'n' is missing.")
  }
  if (!is.numeric(n) || n <= 1 || n != floor(n)) {
    stop("Argument 'n' must be an integer > 1.")
  }
  cat("Welcome to gaawr2", n, "times!\n")
}
