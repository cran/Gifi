morals <- function (x, y, xknots = knotsGifi(x, "Q"), yknots = knotsGifi(y, "Q"), xdegrees = 2, ydegrees = 2, xordinal = TRUE, yordinal = TRUE, 
                    xties = "s", yties = "s", xmissing = "m", ymissing = "m", xactive = TRUE, xcopies = 1, itmax = 1000, 
                    eps = 1e-6, verbose = FALSE) {
    
    ## --- sanity checks 
    x <- as.data.frame(x)
    y <- as.data.frame(y)
    ynames <- "Y"
    xnames = colnames (x, do.NULL = FALSE)
    ## --- end sanity checks
    
    npred <- ncol(x)
    nobs <- nrow(x)
    xdegrees <- reshape(xdegrees, npred)
    xordinal <- reshape(xordinal, npred)
    xties <- reshape(xties, npred)
    xmissing <- reshape(xmissing, npred)
    xactive <- reshape(xactive, npred)
    xcopies <- reshape(xcopies, npred)
    g <- makeGifi(data = cbind (x, y), knots = c (xknots, yknots), degrees = c (xdegrees, ydegrees), ordinal = c (xordinal, yordinal), 
                  sets =  c (rep(1, npred), 2), copies = c (xcopies, 1), ties = c (xties, yties), missing = c (xmissing, ymissing), 
                  active = c (xactive, TRUE), names = c (xnames, ynames))
    h <- gifiEngine(gifi = g, ndim = 1, itmax = itmax, eps = eps, verbose = verbose)
    xhat <- matrix (0, nobs, 0)
    for (j in 1:npred) xhat <- cbind (xhat, h$xGifi[[1]][[j]]$transform)
    yhat <- h$xGifi[[2]][[1]]$transform
    rhat <- cor (cbind (xhat, yhat))
    qxy <- lsRC(xhat, yhat)$solution
    ypred <- xhat %*% qxy
    yres <- yhat - ypred
    smc <- sum (yhat * ypred)
    
    #return (structure(list(objscores = h$x, xhat = xhat, yhat = yhat, rhat = rhat, beta = qxy, ypred = ypred, yres = yres, smc = smc, 
    #                       ntel = h$ntel, f = h$f), class = "morals"))
    
    ## --- output cosmetics
    data_orig <- data.frame(y, x)
    names(yordinal) <- names(yknots) <- colnames(data_orig)[1]
    qxy <- as.vector(qxy)
    names(qxy) <- names(xordinal) <- names(xknots) <- colnames(data_orig)[-1]
    
    try(colnames(xhat) <- colnames(x), silent = TRUE)
    #degvec <- reshape(degrees, nvars); try(names(degvec) <- names, silent = TRUE)
    #ordvec <- reshape(ordinal, nvars); try(names(ordvec) <- names, silent = TRUE)
    
    res <- list(rhat = rhat, objectscores = h$x, xhat = xhat, yhat = as.vector(yhat), beta = qxy, ypred = as.vector(ypred), yres = as.vector(yres), smc = smc, 
                ntel = h$ntel, f = h$f, xknots = xknots, yknots = yknots, yordinal = yordinal, xordinal = xordinal, data = data_orig, call = match.call())
    class(res) <- c("morals")
    return(res)
    
  }