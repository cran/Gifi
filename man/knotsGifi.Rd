\name{knotsGifi}
\alias{knotsGifi}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Utility function for Gifi knot specifications. 
}
\description{
Produces a list of knots used as input argument in various Gifi functions (\code{homals}, \code{princals}, \code{morals}, etc.). Contains options for placing knots at the quantiles, for knots equally spaced on the range, for knots at the data points, and for no interior knots.
}
\usage{
knotsGifi(x, type = c("Q", "R", "E", "D"), n = 3)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{Data frame}
  \item{type}{\code{"Q"} for knots at the quantiles, \code{"R"} for equally spaced knots, \code{"E"} for no interior knots, \code{"D"} for knots at the data points}
  \item{n}{Number of interior knots (ignored for \code{type = "E"} and \code{type = "D"})}
}
\details{
Simple linear or polynomial transformations can be specified using \code{type = "E"} and the corresponding degree in the subsequent Gifi function call. If the data frame contains factors, they are converted internally to numeric 
using \code{makeNumeric}. 
}
\value{
A list containing knots for each variable.
}

\examples{
ABC6 <- ABC[,6:11]
knotsGifi(ABC6, "Q")      ## tercile knots
knotsGifi(ABC6, "Q", 4)   ## quartile knots
knotsGifi(ABC6, "R")      ## 3 equally spaced interior knots
knotsGifi(ABC6, "E")      ## no interior knots
knotsGifi(ABC6, "D")      ## knots at the data points
}
\keyword{utilities}% use one of  RShowDoc("KEYWORDS")
