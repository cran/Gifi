princals <- function (data, ndim = 2, ordinal = TRUE, ties = "s", knots = knotsGifi(data, "D"), degrees = 2, copies = 1, 
                      missing = "m", normobj.z = TRUE, active = TRUE, itmax = 1000, eps = 1e-6, verbose = FALSE)  {
    
    ## --- sanity checks
    names <- colnames(data, do.NULL = FALSE) 
    rnames <- rownames(data, do.NULL = FALSE)
    data_orig <- data
    data <- makeNumeric(data)   
    ties <- match.arg(ties, c("s", "p", "t"), several.ok = FALSE)
    missing <- match.arg(missing, c("m", "s", "a"), several.ok = FALSE)
    ## --- end sanity checks
  
    aname <- deparse(substitute(data))
    nvars <- ncol(data)
    nobs <- nrow(data)
    g <- makeGifi(data = data, knots = knots, degrees = reshape(degrees, nvars), ordinal = reshape(ordinal, nvars),
                  sets =  1:nvars, copies = reshape(copies, nvars), ties = reshape (ties, nvars), missing = reshape (missing, nvars),
                  active = reshape (active, nvars), names = names)
    h <- gifiEngine(gifi = g, ndim = ndim, itmax = itmax, eps = eps, verbose = verbose)
    a <- v <- z <- d <- y <- o <- as.list (1:nvars)
    dsum <- matrix (0, ndim, ndim)
    for (j in 1:nvars) {
      jgifi <- h$xGifi[[j]][[1]]
      v[[j]] <- jgifi$transform
      a[[j]] <- jgifi$weights
      y[[j]] <- jgifi$scores
      z[[j]] <- jgifi$quantifications
      cy <- crossprod (y[[j]])
      dsum <- dsum + cy
      d[[j]] <- cy
      o[[j]] <- crossprod (h$x, v[[j]])
    }
    
    # return (structure(list(transform = v, rhat = corList(v), objectscores = h$x, scores = y, quantifications = z,
    #                        dmeasures = d, lambda = dsum/ncol (data), weights = a, loadings = o, ntel = h$ntel, f = h$f),
    #   class = "princals"
    # ))
    
   ## --- output cosmetics
   dnames <- paste0("D", 1:ndim)
   
   transform <- do.call(cbind, v); try(colnames(transform) <- names, silent = TRUE); try(rownames(transform) <- rnames, silent = TRUE)
   
   rhat <- corList(v); try(rownames(rhat) <- colnames(rhat) <- names, silent = TRUE)
   evals <- eigen(rhat)$values
   
   objectscores <- as.matrix(h$x); try(colnames(objectscores) <- dnames, silent = TRUE); try(rownames(objectscores) <- rnames, silent = TRUE)
   if (normobj.z) objectscores <- nobs^0.5 * objectscores  
   
   scoremat <- sapply(y, function(xx) xx[,1]); try(colnames(scoremat) <- names, silent = TRUE); try(rownames(scoremat) <- rnames, silent = TRUE)
   quantifications <- as.matrix(z); try(names(quantifications) <- names, silent = TRUE); try(quantifications <- lapply(quantifications, "colnames<-", dnames), silent = TRUE)
   
   dmeasures <- d; try(names(dmeasures) <- names, silent = TRUE); try(dmeasures <- lapply(dmeasures, "colnames<-", dnames), silent = TRUE); try(dmeasures <- lapply(dmeasures, "rownames<-", dnames), silent = TRUE)
   lambda <- dsum/ncol(data); try(rownames(lambda) <- colnames(lambda) <- dnames, silent = TRUE)
   weights <- do.call(rbind, a); try(rownames(weights) <- names, silent = TRUE); try(colnames(weights) <- dnames, silent = TRUE)
   loadings <- do.call(cbind, o); try(rownames(loadings) <- dnames, silent = TRUE); try(colnames(loadings) <- names, silent = TRUE)
   ntel <- h$ntel
   f <- h$f
   
   knotlist <- knots; try(names(knotlist) <- names, silent = TRUE)
   degvec <- reshape(degrees, nvars); try(names(degvec) <- names, silent = TRUE)
   ordvec <- reshape(ordinal, nvars); try(names(ordvec) <- names, silent = TRUE)
   
   res <- list(transform = transform, rhat = rhat, evals = evals, objectscores = objectscores, scoremat = scoremat, quantifications = quantifications,
               dmeasures = dmeasures, lambda = lambda, weights = weights, loadings = t(loadings), ntel = ntel, f = f, 
               data = data_orig, datanum = data, ndim = ndim, knots = knotlist, degrees = degvec, ordinal = ordvec,
               call = match.call())
   class(res) <- c("princals", "gifi")
   return(res)
  }