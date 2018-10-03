\name{NEWS}
\title{News for Package \pkg{Gifi}}
\encoding{UTF-8}

\section{Version 0.1-0}{
 \itemize{
    \item Princals wrapper incl. S3 print added.
    \item Bug in makeNumeric fixed.
    }
}

\section{Version 0.1-1}{
 \itemize{
    \item Allow for different object score and quantification normalizations.
    \item Knot utility functions functions and makeNumeric exported.
    \item Princals S3 summary added.
    \item Allow for different ties and missing specifications.
    \item knotsD as default in princals.
    \item Knot functions now work for single variables as well.
  }
}

\section{Version 0.1-2}{
 \itemize{
    \item \code{ylim} scree plot starts at 0.
    \item Help file for \code{plot.princals} added.
    \item Aspect ratio for 2D plots set to 1.
    \item Color argument for lines in transplot and screeplot.
  }
}

\section{Version 0.2-0}{
 \itemize{
    \item \code{homals} wrapper added
    \item \code{plot}, \code{summary}, \code{print} S3 for homals added.
    \item Some cosmetics on the transformation plot.
    \item Attribute assigned to knot functions.
  }
}

\section{Version 0.3-0}{
 \itemize{
    \item bug for \code{plot.dim = 1} in transformation plot fixed.
    \item \code{morals} wrapper incl. S3 (print, plot) added.
  }
}

\section{Version 0.3-1}{
 \itemize{
    \item \code{scale} argument in princals biplot added.
  }
}

\section{Version 0.3-2}{
 \itemize{
    \item Biplot part in \code{plot.princals} rewritten. Now is uses \code{biplot} from \code{stats}.
    \item New \code{knotsGifi} function which replaces the old knots functions. 
    \item Panel option added for transformation plots. 
  }
}

\section{Version 0.3-4}{
 \itemize{
    \item \code{cv.morals} for cross-validating morals objects added.
  }
}

\section{Version 0.3-5}{
 \itemize{
    \item \code{seed} arguments removed from all functions.
  }
}