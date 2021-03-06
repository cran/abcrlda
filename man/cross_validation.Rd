% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/abc_grid.R
\name{cross_validation}
\alias{cross_validation}
\title{Cross Validation for separate sampling adjusted for cost.}
\usage{
cross_validation(
  x,
  y,
  gamma = 1,
  cost = c(0.5, 0.5),
  nfolds = 10,
  bias_correction = TRUE
)
}
\arguments{
\item{x}{Input matrix or data.frame of dimension \code{nobs x nvars}; each row is an feature vector.}

\item{y}{A numeric vector or factor of class labels. Factor should have either two levels or be
a vector with two distinct values.
If \code{y} is presented as a vector, it will be coerced into a factor.
Length of \code{y} has to correspond to number of samples in \code{x}.}

\item{gamma}{Regularization parameter \eqn{\gamma}{gamma} in the ABC-RLDA discriminant function given by:
\deqn{W_{ABC}^{RLDA} = \gamma (x-\frac{\bar{x}_0 +
\bar{x}_1}{2})^T H (\bar{x}_0 - \bar{x}_1)
- log(\frac{C_{01}}{C_{10}}) + \hat{\omega}_{opt}}{W_ABCRLDA = gamma (x - (x0 + x1)/2) H (x0 - x1) + log(C_01/C_10) + omega_opt}
\deqn{H = (I_p + \gamma \hat{\Sigma})^{-1}}{H = (I_p + gamma Sigma_hat)^-1}
Formulas and derivations for parameters used in above equation can be found in the article under reference section.}

\item{cost}{Parameter that controls the overall misclassification costs.
 This is a vector of length 1 or 2 where the first value is \eqn{C_{10}}{C_10} (represents the cost of assigning label 1 when the true label is 0)
 and the second value, if provided, is \eqn{C_{01}}{C_01} (represents the cost of assigning label 0 when the true label is 1).
 The default setting is c(0.5, 0.5), so both classes have equal misclassification costs

 If a single value is provided, it should be normalized to lie between 0 and 1 (but not including 0 or 1).
 This value will be assigned to \eqn{C_{10}}{C_10} while
 \eqn{C_{01}}{C_01} will be equal to \eqn{(1 - C_{10})}{1 - C_10}.}

\item{nfolds}{Number of folds to use with cross-validation. Default is 10.
In case of imbalanced data, \code{nfolds} should not be greater than the number of observations in
smaller class.}

\item{bias_correction}{Takes in a boolean value.
If \code{bias_correction} is TRUE, then asymptotic bias correction will be performed.
Otherwise, (if \code{bias_correction} is FALSE) asymptotic bias correction will not be performed and
the ABCRLDA is the classical RLDA.
The default is TRUE.}
}
\value{
Returns list of parameters.
  \item{risk_cross}{Returns risk estimation where \eqn{\Re = \varepsilon_0 * C_{10} + \varepsilon_1 * C_{01}}{R = e_0 * C_10 + e_1 * C_01)}}
  \item{e_0}{Error estimate for class 0.}
  \item{e_1}{Error estimate for class 1.}
}
\description{
This function implements Cross Validation for separate sampling adjusted for cost.
}
\section{Reference}{

  Braga-Neto, Ulisses & Zollanvari, Amin & Dougherty, Edward. (2014).
  Cross-Validation Under Separate Sampling: Strong Bias and How to Correct It.
  Bioinformatics (Oxford, England). 30. 10.1093/bioinformatics/btu527.
  URL: \url{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4296143/pdf/btu527.pdf}
}

\examples{
data(iris)
train_data <- iris[which(iris[, ncol(iris)] == "virginica" |
                         iris[, ncol(iris)] == "versicolor"), 1:4]
train_label <- factor(iris[which(iris[, ncol(iris)] == "virginica" |
                                 iris[, ncol(iris)] == "versicolor"), 5])
cross_validation(train_data, train_label, gamma = 10)
}
\seealso{
Other functions in the package: 
\code{\link{abcrlda}()},
\code{\link{da_risk_estimator}()},
\code{\link{grid_search}()},
\code{\link{predict.abcrlda}()},
\code{\link{risk_calculate}()}
}
\concept{functions in the package}
