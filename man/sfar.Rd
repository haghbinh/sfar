% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sfar_func.r
\name{sfar}
\alias{sfar}
\title{Estimation of an SFAR(1) Model}
\usage{
sfar(
  X,
  seasonal,
  cpv = 0.85,
  kn = NULL,
  method = c("MME", "ULSE", "KOE"),
  a = ncol(Coefs)^(-1/6)
)
}
\arguments{
\item{X}{a functional time series.}

\item{seasonal}{a positive integer variable specifying the seasonality parameter.}

\item{cpv}{a numeric with values in [0,1] which determines the cumulative proportion variance explained by the first kn eigencomponents.}

\item{kn}{an integer variable specifying the number of eigencomponents.}

\item{method}{a character string giving the method of estimation. The following values are possible:
"MME" for Method of Moments, "ULSE" for Unconditional Least Square Estimation Method, and "KOE" for Kargin-Ontaski Estimation.}

\item{a}{a numeric with value in [0,1].}
}
\value{
A matrix of size p*p.
}
\description{
Estimate a seasonal functional autoregressive (SFAR) model of order 1 for a given functional time series.
}
\examples{
# Generate Brownian motion noise
N <- 300 # the length of the series
n <- 200 # the sample rate that each function will be sampled
u <- seq(0, 1, length.out = n) # argvalues of the functions
d <- 45 # the number of bases
basis <- create.fourier.basis(c(0, 1), d) # the basis system
sigma <- 0.05 # the std of noise norm
Z0 <- matrix(rnorm(N * n, 0, sigma), nrow = n, nc = N)
Z0[, 1] <- 0
Z_mat <- apply(Z0, 2, cumsum) # N standard Brownian motion
Z <- smooth.basis(u, Z_mat, basis)$fd

# Simulate random SFAR(1) data
kr <- function(x, y) {
 (2 - (2 * x - 1)^2 - (2 * y - 1)^2) / 2
}
s <- 5 # the period number
X <- rsfar(kr, s, Z)
plot(X)

# SFAR(1) model parameter estimation:
Model1 <- sfar(X, seasonal = s, kn = 1)
}
