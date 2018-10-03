plot.princals <- function(x, plot.type = "loadplot", plot.dim = c(1, 2), var.subset = "all", 
                          col.scores = "black", col.loadings = "black", col.lines = "black", cex.scores = 0.8, 
                          cex.loadings = 0.8, stepvec = NA, max.plot.array = c(2, 2), expand = 1, 
                          asp = 1, main, xlab, ylab, xlim, ylim, ...)
  {
    
    ## S3 plot method for objects of class "princals"
    ## Produces various 2D-plots
    ## plot.dim ... vector of length 2 with dimensions to be plotted against
    ## plot.type ... type of plot to be drawn: "loadplot", "screeplot", "biplot", "transplot"
    
    match.arg(plot.type, c("biplot", "loadplot", "screeplot", "transplot"))
    
    if ((x$ndim == 1) && (plot.type != "transplot")) stop("No biplot/loadings plot can be drawn for ndim = 1!")
    nvar <- dim(x$loadings)[1]
    
    
    
    #----------------------------------loadplot-------------------------------------
    if (plot.type == "loadplot") {
      xycoor <- x$loadings[,plot.dim]
      if (missing(xlim)) {                            ## x limits
        xlim.min <- min(xycoor[,1],0)
        xlim.max <- max(xycoor[,1],0)
        xlim <- c(xlim.min, xlim.max)*1.2
      }
      if (missing(ylim)) {                            ## y limits
        ylim.min <- min(xycoor[,2],0)
        ylim.max <- max(xycoor[,2],0)
        ylim <- c(ylim.min, ylim.max)*1.2
      }
      if (missing(xlab)) xlab <- paste("Component", plot.dim[1])       ## labels
      if (missing(ylab)) ylab <- paste("Component", plot.dim[2])  
      if (missing(main)) main <- "Loadings Plot"
      
      plot(xycoor, type = "p", pch = ".", xlim = xlim, ylim = ylim, xlab = xlab, ylab = ylab, main = main, 
           cex = cex.loadings, col = col.loadings, asp = asp, ...)
      abline(h = 0, v = 0, col = "gray", lty = 2)
      if (length(col.loadings) == 1) arcol <- rep(col.loadings, nvar) else arcol <- col.loadings
      for (i in 1:nvar) arrows(0, 0, xycoor[i,1],xycoor[i,2], length = 0.08, col = arcol[i])   
      posvec <- apply(xycoor, 1, sign)[2,] + 2      
      text(xycoor, labels = rownames(xycoor), pos = posvec, cex = cex.loadings, col = col.loadings)
      
    }
    #-------------------------------- end loadplot ---------------------------------
    
    ## --------------------------------- biplot ------------------------------------
    if (plot.type == "biplot") {
      if (missing(main)) main <- "Biplot"
      if (missing(xlab)) xlab <- paste("Component", plot.dim[1])       ## labels
      if (missing(ylab)) ylab <- paste("Component", plot.dim[2])  
      
      cols <- c(col.scores, col.loadings)
      cexs <- c(cex.scores, cex.loadings)
      biplot(x$objectscores[,plot.dim], x$loadings[,plot.dim], expand = expand,
                             col = cols, cex = cexs, main = main, xlab = xlab, ylab = ylab, 
                             arrow.len = 0.08, ...)
    }
    
    #------------------------------------transplot------------------------------------
    if (plot.type == "transplot") {
      if (missing(xlab)) xlab <- "Observed"
      if (missing(ylab)) ylab <- "Transformed"
      
      if (var.subset[1] == "all") var.subset <- rownames(x$loadings)       ## extract variables and scores to be plotted
      if (is.numeric(var.subset)) var.subset <- rownames(x$loadings)[var.subset]
      if (missing(main)) main <- var.subset
      
      nvars <- length(var.subset)                                 ## number of variables to be plotted
      plotvars <- as.matrix(x$datanum[,var.subset])   
      xlabels <- as.data.frame(x$data[,var.subset])
      ploty <- as.matrix(x$transform[,var.subset])
      knotsv <- x$knots[var.subset]
      ordv <- x$ordinal[var.subset]
      
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
      
      ## begin plotting
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
