print.gifi <- function(x, ...) {
  cat("Call:\n")
  print(x$call)
  cat("\n")
  cat("Loss value:", round(x$f, 3),"\n")
  cat("Number of iterations:",x$ntel,"\n")
  cat("\n")
  cat("Eigenvalues:", round(x$evals[1:x$ndim], 3), "\n")
  cat("\n")
}
