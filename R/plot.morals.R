plot.morals <- function(x, plot.type = "transplot", var.subset = "all", col.lines = "black", 
                        stepvec = NA, max.plot.array = c(2, 2), main, xlab, ylab, xlim, ylim, ...)
  {
    
    ## S3 plot method for objects of class "morals"
    ## Produces various 2D-plots
    ## plot.dim ... vector of length 2 with dimensions to be plotted against
    ## plot.type ... type of plot to be drawn
    
    match.arg(plot.type, c("resplot", "transplot"))
    
    if (plot.type == "resplot") {
      if (missing(xlab)) xlab <- "Fitted Values"
      if (missing(ylab)) ylab <- "Residuals"
      if (missing(main)) main <- "Residuals vs. Fitted"
      plot(x$ypred, x$yres, xlab = xlab, ylab = ylab, main = main, ...)
    }
    
    
    #------------------------------------transplot------------------------------------
    if (plot.type == "transplot") {
      if (missing(xlab)) xlab <- "Observed"
      if (missing(ylab)) ylab <- "Transformed"
      
      if (var.subset[1] == "all") var.subset <- colnames(x$data)       ## extract variables and scores to be plotted
      if (is.numeric(var.subset)) var.subset <- colnames(x$data)[var.subset]
      if (missing(main)) main <- var.subset
      
      nvars <- length(var.subset)                                 ## number of variables to be plotted
      plotvars <- as.matrix(x$data[,var.subset])   
      xlabels <- as.data.frame(x$data[,var.subset])
      transform <- cbind(x$yhat, x$xhat)
      colnames(transform) <- colnames(x$data)
      ploty <- as.matrix(transform[,var.subset])
      knotsv <- c(x$yknots, x$xknots)
      ordv <- c(x$yordinal, x$xordinal)[var.subset]
      
      ## set up number of vertical and horizontal panels  
      if (missing(max.plot.array)) {
        npanv <- ceiling(sqrt(nvars))
        npanh <- floor(sqrt(nvars))
        if (npanv * npanh < nvars) npanv <- npanv + 1
        if (npanv == 1 && npanh == 1) parop <- FALSE else parop <- TRUE
      } else {
        if (length(max.plot.array) < 2){
          npanv <- max.plot.array[1]
          npanh <- max.plot.array[1]
        } else {
          npanv <- max.plot.array[1]
          npanh <- max.plot.array[2]
        }
        npanv <- max(npanv, 1)
        npanh <- max(npanh, 1)
        if (npanv == 1 && npanh == 1) parop <- FALSE else parop <- TRUE
      }
      if (parop) op <- par(mfrow = c(npanv, npanh))
      
      for (i in 1:nvars) {
        x1 <- plotvars[,i]
        y1 <- ploty[,i]
        xy <- cbind(x1, y1)
        ord <- order(xy[,1])
        
        if (!is.factor(xlabels[,i])) xlabels[,i] <- round(xlabels[,i], 2)
        if (is.na(stepvec[1])) crit <- length(knotsv[[i]]) == (length(unique(plotvars[,i]))-2) else crit <- stepvec[i]
        if (crit) {    ## plot step function
          sfun0  <- stepfun(xy[ord,1][-1], xy[ord,2], f = 0)    
          if (ordv[i]) vert <- TRUE else vert <- FALSE
          plot(sfun0, xlab = xlab, ylab = ylab, main = main[i], xaxt = "n", col = col.lines, do.points = FALSE, verticals = vert, ...)
          axis(1, labels = xlabels[,i], at = x1) 
        } else {
          plot(xy[ord,1], xy[ord,2], type = "l", xlab = xlab, ylab = ylab, main = main[i], xaxt = "n", col = col.lines, ...)
          axis(1, labels = xlabels[,i], at = x1) 
        }
      }
      if (parop) on.exit(par(op))
    }    
    # #----------------------------------end transplot----------------------------------
    
    
    #---------------------------------- screeplot ----------------------------------
    if (plot.type == "screeplot") {
      
      if (missing(main)) main <- "Scree Plot"
      if (missing(xlab)) xlab <- "Number of Components"
      if (missing(ylab)) ylab <- "Eigenvalues"
      if (missing(ylim)) ylim <- c(0, max(x$evals))
      
      nd <- length(x$evals)
      plot(1:nd, x$evals, type = "b", xlab = xlab, ylab = ylab, main = main, xaxt = "n", pch = 20,
           ylim = ylim, col = col.lines, ...)
      axis(1, at = 1:nd, labels = 1:nd)
    }  
    #-------------------------------- end screeplot --------------------------------
    
  
}
