## utility function to bipass manual spline specification

level_to_spline <- function(levels, data) {
  ordvec <- rep(NA, ncol(data))
  knotList <- list(NA, ncol(data))
  levels <- match.arg(levels, c("nominal", "ordinal", "metric"), several.ok = TRUE)
  for (i in 1:length(levels)) {
    if (levels[i] == "nominal") {
      ordvec[i] <- FALSE
      knotList[[i]] <- knotsGifi(data[,i], "D")[[1]]
    }
    if (levels[i] == "ordinal") {
      ordvec[i] <- TRUE
      knotList[[i]] <- knotsGifi(data[,i], "D")[[1]]
    }
    if (levels[i] == "metric") {
      ordvec[i] <- TRUE
      knotList[[i]] <- knotsGifi(data[,i], "E")[[1]]
    }
  }
  res <- list(knotList = knotList, ordvec = ordvec)
  return(res)
}



