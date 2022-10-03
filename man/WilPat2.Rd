\name{WilPat2}
\alias{WilPat2}
\docType{data}
\title{
Wilson-Patterson Conservatism Scale
}
\description{
This dataset contains a modified version of the classical Wilson-Patterson conservatism scale. Here we use a subset of the data included in the \code{MPsychoR} package.
}

\usage{
data("WilPat2")
}


\format{
The first 15 items are conservative items, the remaining ones are liberal. Each item has the following response categories: 0 ... disapprove, 1 ... approve, 2 ... don't know. There are 493 persons in the sample. In addition there are the following covariates:
\describe{
	\item{\code{Country}}{Participant's country.}
  \item{\code{LibCons}}{Self-reported liberalism/conservatism.}
  \item{\code{LeftRight}}{Self-reported left/right identification.}
  \item{\code{Gender}}{Gender.}
  \item{\code{Age}}{Age.}
}
}

\note{
Thanks to Benedek Kurdi and Levente Littvay for providing this dataset. 
}

\examples{
data("WilPat2")
str(WilPat2)
}
\keyword{datasets}
