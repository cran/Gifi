## knots function 

knotsGifi <- function(x, type = c("Q", "R", "E", "D"), n = 3) { 
  
  ## type:
  ## Q ... knots at the quantiles
  ## R ... equally spaces knots
  ## E ... no interior knots
  ## D ... knots at the data points
  
  ## x ... data
  ## n ... number of interior knots
  
  type <- match.arg(type, c("Q", "R", "E", "D"), several.ok = FALSE)
  
  if (type == "Q")  { 
    n <- n + 2              ## interior + exterior knots
    x <- as.data.frame(x)
    x <- makeNumeric(x)
    doQ <- function (z, n) {
      y <- quantile (z, probs = seq(0, 1, length = max (2, n)))
      return (y[-c(1, length(y))])
    }
    if (ncol(x) > 0) n <- rep (n, ncol (x))
    if (ncol(x) > 0) out <- lapply (1:ncol(x), function (i) doQ(x[,i], n[i]))
    attr(out, "type") <- "knotsQ"
  }
  
  if (type == "R") {
    n <- n + 2
    n <- rep(n, ncol(x))
    x <- as.data.frame(x)
    x <- makeNumeric(x)
    doR <- function (i) {
      y <- seq (min(x[, i]), max(x[, i]), length = max (2, n[i]))
      return (y[-c(1, length(y))])
    }
    out <- lapply (1:ncol(x),  function (i) doR(i))
    attr(out, "type") <- "knotsR"
  }
  
  if (type == "E") {
    x <- as.data.frame(x)
    x <- makeNumeric(x)
    out <- lapply (1:max(1, ncol(x)), function (i) numeric(0))
    attr(out, "type") <- "knotsE"
  }
  
  if (type == "D") {
    x <- as.data.frame(x)
    x <- makeNumeric(x)
    doD <- function (i) {
      y <- sort (unique(x[, i]))
      return (y[-c(1, length(y))])
    }
    out <- lapply (1:ncol(x),  function (i) doD(i))
    attr(out, "type") <- "knotsD"
  }
  return(out)
}
