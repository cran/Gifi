summary.homals <- function(object, ...) {
  cat("\nImportance (Variance Accounted For):\n")
  nvars <- length(object$loadings)
  ndim <- object$ndim
  sevals <- sum(object$evals)
  df <- as.data.frame(rbind(round(object$evals[1:ndim], 4), 
                            round((object$evals/sevals*100)[1:ndim], 4), 
                            round((cumsum(object$evals/sevals*100))[1:ndim], 4)))
  colnames(df) <- paste0("Dim", 1:ncol(df))
  rownames(df) <- c("Eigenvalues", "VAF", "Cumulative VAF")
  print(df)
  cat("\n")
}
