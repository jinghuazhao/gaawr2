# tests/testthat/test-welcome.R

library(testthat)
test_that("welcome() works correctly", {
  
  # Test for valid input (n > 1)
  expect_output(welcome(2), "Welcome to gaawr2 2 times!")
  expect_output(welcome(5), "Welcome to gaawr2 5 times!")

  # Test for missing argument
  expect_error(welcome(), "Argument 'n' is missing.")

  # Test for non-numeric input
  expect_error(welcome("hello"), "Argument 'n' must be an integer > 1.")
  expect_error(welcome(TRUE), "Argument 'n' must be an integer > 1.")
  expect_error(welcome(2.5), "Argument 'n' must be an integer > 1.")

  # Test for invalid numeric input (n ≤ 1)
  expect_error(welcome(1), "Argument 'n' must be an integer > 1.")
  expect_error(welcome(0), "Argument 'n' must be an integer > 1.")
  expect_error(welcome(-3), "Argument 'n' must be an integer > 1.")
})
