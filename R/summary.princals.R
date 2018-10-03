summary.princals <- function(object, digits = 3, cutoff = 0.1, sort = TRUE, ...) {
  Lambda <- unclass(object$loadings)
  colnames(Lambda) <- paste0("Comp", 1:ncol(Lambda))
  p <- nrow(Lambda)
  factors <- ncol(Lambda)
  if (sort) {
    mx <- max.col(abs(Lambda))
    ind <- cbind(1L:p, mx)
    mx[abs(Lambda[ind]) < 0.5] <- factors + 1
    Lambda <- Lambda[order(mx, 1L:p), ]
  }
  cat("\nLoadings (cutoff = ", cutoff, "):\n", sep = "")
  fx <- setNames(format(round(Lambda, digits)), NULL)
  nc <- nchar(fx[1L], type = "c")
  fx[abs(Lambda) < cutoff] <- strrep(" ", nc)
  print(fx, quote = FALSE, ...)
  
  cat("\nImportance (Variance Accounted For):\n")
  nvars <- nrow(object$loadings)
  ndim <- nrow(object$lambda)
  df <- as.data.frame(rbind(round(object$evals[1:ndim], 4), 
                            round((object$evals/nvars*100)[1:ndim], 4), 
                            round(cumsum((object$evals/nvars)[1:ndim])*100, 2)))
  colnames(df) <- paste0("Comp", 1:ncol(df))
  rownames(df) <- c("Eigenvalues", "VAF", "Cumulative VAF")
  print(df)
  cat("\n")
}
