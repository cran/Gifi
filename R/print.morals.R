print.morals <- function(x, ...) {
  cat("Call:\n")
  print(x$call)
  cat("\n")
  cat("Loss value:", round(x$f, 3),"\n")
  cat("Number of iterations:",x$ntel,"\n")
  cat("\n")
  cat("Coefficients:\n")
  print(round(x$beta, 4))
  cat("\nMultiple R-squared:", round(x$smc, 3), "\n\n")
}
