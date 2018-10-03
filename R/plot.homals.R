plot.homals <- function(x, plot.type = "jointplot", plot.dim = c(1, 2), var.subset = "all", 
                        col.points = rainbow_hcl(ncol(x$data)), col.scores = "gray", 
                        col.lines = 1:x$ndim, cex.scores = 0.8, cex.loadings = 0.8, 
                        labels.scores = FALSE, stepvec = NA, max.plot.array = c(2, 2), 
                        asp = 1, main, xlab, ylab, xlim, ylim, ...)
  {
    
    ## S3 plot method for objects of class "princals"
    ## Produces various 2D-plots
    ## plot.dim ... vector of length 2 with dimensions to be plotted against
    ## plot.type ... type of plot to be drawn: "loadplot", "screeplot", "biplot", "transplot"
    
    match.arg(plot.type, c("jointplot", "biplot", "screeplot", "transplot"))
    
    if ((x$ndim == 1) && (plot.type != "transplot")) stop("No plot can be drawn for ndim = 1!")
    nvar <- length(x$quantifications)
    vnames <- colnames(x$data)
    
    
    
    #----------------------------------jointplot-------------------------------------
    if (plot.type == "jointplot") {
      xycoor <- do.call(rbind, x$quantifications)[,plot.dim]
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
      if (missing(xlab)) xlab <- paste("Dimension", plot.dim[1])       ## labels
      if (missing(ylab)) ylab <- paste("Dimension", plot.dim[2])  
      if (missing(main)) main <- "Joint Plot"
      
      if (var.subset[1] == "all") {
        vars <- 1:nvar
      } else {
        if (is.numeric(var.subset)) vars <- var.subset else vars <- match(var.subset, vnames)
      }  
      if (length(col.points) == 1) rep(col.points, nvar)
      plot(xycoor, type = "n", xlim = xlim, ylim = ylim, xlab = xlab, ylab = ylab, main = main, asp = asp, ...)
      for (i in vars) {
        points(x$quantifications[[i]][,plot.dim], col = col.points[i], pch = 20, cex = 0.8)
        text(x$quantifications[[i]][,plot.dim], labels = paste(names(x$quantifications)[i], rownames(x$quantifications[[i]]), sep = "."), 
            col = col.points[i], pos = 3, cex = 0.8)
      }
      abline(h = 0, v = 0, lty = 2, col = "gray")
    }
    #-------------------------------- end jointplot ---------------------------------
    
    ## --------------------------------- biplot ------------------------------------
    if (plot.type == "biplot") {
      normobj <- round(apply(x$objectscores^2, 2, sum)[1])
      #if (normobj != 1) stop("For biplot re-fit the model with normobj.z = FALSE.")
     
      xycoorS <- x$objectscores[,plot.dim]
      xycoor <- rbind(do.call(rbind, x$quantifications)[,plot.dim], xycoorS)
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
      if (missing(xlab)) xlab <- paste("Dimension", plot.dim[1])        ## labels
      if (missing(ylab)) ylab <- paste("Dimension", plot.dim[2]) 
      if (missing(main)) main <- "Biplot"
      
      if (var.subset[1] == "all") {
        vars <- 1:nvar
      } else {
        if (is.numeric(var.subset)) vars <- var.subset else vars <- match(var.subset, vnames)
      }  
      if (length(col.points) == 1) rep(col.points, nvar)
      
      plot(xycoor, type = "n", xlim = xlim, ylim = ylim, xlab = xlab, ylab = ylab, main = main, asp = asp, ...)
      
      ## objectscores
      if (labels.scores) {
        text(xycoorS, labels = rownames(xycoorS), col = col.scores, cex = cex.scores)
      } else {
        points(xycoorS, type = "p", pch = 1, cex = cex.scores, col = col.scores)
      }
      
      ## category scores (as in jointplot)
      for (i in vars) {
        points(x$quantifications[[i]][,plot.dim], col = col.points[i], pch = 20, cex = 0.8)
        text(x$quantifications[[i]][,plot.dim], labels = paste(names(x$quantifications)[i], rownames(x$quantifications[[i]]), sep = "."), 
             col = col.points[i], pos = 3, cex = 0.8)
      }
      abline(h = 0, v = 0, lty = 2, col = "gray")
    }
    
    
    #------------------------------------transplot------------------------------------
    if (plot.type == "transplot") {
      
      if (missing(xlab)) xlab <- "Observed"
      if (missing(ylab)) ylab <- "Transformed"
      
      if (var.subset[1] == "all") var.subset <- names(x$transform)       ## extract variables and scores to be plotted
      if (is.numeric(var.subset)) var.subset <- names(x$loadings)[var.subset]
      if (missing(main)) main <- var.subset
      
      nvars <- length(var.subset)                                 ## number of variables to be plotted
      plotvars <- as.matrix(x$datanum[,var.subset])   
      xlabels <- as.data.frame(x$data[,var.subset])
      ploty <- x$transform[var.subset]   ## list
      ploty <- lapply(ploty, function(cc) if (ncol(cc) < length(plot.dim)) as.matrix(cc) else as.matrix(cc[, plot.dim]))
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
      
      for (i in 1:nvars) {
        ylims <- range(c(ploty[[i]]))*1.05
        for (j in 1:ncol(ploty[[i]])) {
          x1 <- plotvars[,i]
          y1 <- ploty[[i]][,j]
          xy <- cbind(x1, y1)
          ord <- order(xy[,1])
          
          if (!is.factor(xlabels[,i])) xlabels[,i] <- round(xlabels[,i], 2)
          if (is.na(stepvec[1])) crit <- (length(knotsv[[i]]) == (length(unique(plotvars[,i]))-2)) else crit <- stepvec[i]
          if (crit) {    ## plot step function
            sfun0  <- stepfun(xy[ord,1][-1], xy[ord,2], f = 0)    
            if (ordv[i]) vert <- TRUE else vert <- FALSE
            if (j == 1) {
              plot(sfun0, xlab = xlab, ylab = ylab, main = main[i], xaxt = "n", col = col.lines[j], do.points = FALSE, 
                   verticals = vert, ylim = ylims, lwd = 2, ...)
              axis(1, labels = xlabels[,i], at = x1) 
              abline(v = x1, col = "gray", lwd = 0.8)
            } else {
              plot(sfun0, xlab = xlab, ylab = ylab, main = main[i], xaxt = "n", col = col.lines[j], do.points = FALSE, 
                   add = TRUE, verticals = vert, lwd = 2)
            }
          } else {
            if (j == 1) {
              plot(xy[ord,1], xy[ord,2], type = "l", xlab = xlab, ylab = ylab, main = main[i], xaxt = "n", col = col.lines[j], 
                   ylim = ylims, lwd = 2, ...)
              axis(1, labels = xlabels[,i], at = x1) 
            } else {
              points(xy[ord,1], xy[ord,2], type = "l", col = col.lines[j], lwd = 2)
            }
          }
  
        }
      }
      if (parop) on.exit(par(op))
    }    
    
    # ----------------------------------end transplot----------------------------------
    
    
    #---------------------------------- screeplot ----------------------------------
    if (plot.type == "screeplot") {
      
      if (missing(main)) main <- "Scree Plot"
      if (missing(xlab)) xlab <- "Number of Dimensions"
      if (missing(ylab)) ylab <- "Eigenvalues"
      if (missing(ylim)) ylim <- c(0, max(x$evals))
      
      nd <- length(x$evals)
      plot(1:nd, x$evals, type = "b", xlab = xlab, ylab = ylab, main = main, xaxt = "n", pch = 20, ylim = ylim, col = col.lines[1], ...)
      axis(1, at = 1:nd, labels = 1:nd)
    }  
    #-------------------------------- end screeplot --------------------------------
    
  
}
