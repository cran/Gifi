cv.morals <- function(object, folds = 10, verbose = FALSE, ...) {
  ## object of class morals
  if ((class(object)[1]) != "morals") stop("CV implemented for Morals only!")
  
  N <- length(object$yhat)        ## number of observations
  if ((folds < 2) || (folds > N)) stop("Number of folds should be within [2; n].")
  
  nleave <- trunc(N/folds)        ## number of observations to be left out per fold
  obssort <- 1:(nleave*folds)
  obsran <- sample(obssort, replace = FALSE)
  indmat <- matrix(obsran, nrow = folds)  ## observations to be left out per fold (row-wise)
  
  #ypreds <- numeric(N)
  
  mse <- numeric(folds)
  for (j in 1:nrow(indmat)) {
    i <- indmat[j,]
    if (verbose) cat("Left-out observations: ", i, "\n")
    dat <- object$data[-i,]          ## data for new model fit (training)
    yobs <- object$yhat[i]
    morcall <- object$call
    morcall$x <- dat[,-1]
    morcall$y <- dat[, 1]             
    morres <- eval(morcall)          ## re-fit morals on training data
    xleft <- object$xhat[i,]         ## left-out observations
    class(xleft) <- "numeric"
    qxy <- lsRC(morres$xhat, morres$yhat)$solution   ## coefficient
    #ypreds[i] <- xleft %*% qxy                       ## predict left-out observation
    ypreds <- xleft %*% qxy
    mse[j] <- mean((ypreds - yobs)^2)
  }
  mean(mse)   ##  CV estimate
} 


