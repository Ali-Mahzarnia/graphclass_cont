
Welcome to the manual of the "graphclass_cont" repository! This repository is a modified version of the "graphclass" R package, which includes new features for incorporating continuous outcome Y and controlling for a number of folds by assigning folds = x and pre-choosing the lambda or letting the system choose it (lambda_selection = TRUE or FALSE). In addition, train_error and test_errors are associated with in sample and out of sample RMSEs.

Installation:
To install this package, please run the following line in R and make sure that the dependencies, such as "gglasso", are installed:

```R  
library(devtools)
install_github("Ali-Mahzarnia/graphclass_cont")
```

Example code:
Once the package is successfully installed, you can use the following example code to run the subgraph selection penalty using the system to choose the lambda through 3-fold cv:

```R 
library(graphclass)

# Load example data
data(COBRE.data)
X <- COBRE.data$X.cobre
Y <- COBRE.data$Y.cobre
Y=Y+rnorm(length(Y))


# Subgraph selection penalty using the system to choose the lambda through 3-fold cv
gc <- graphclass(X = X, Y = Y, type = "intersection", rho = 1, gamma = 1e-5, folds = 3, lambda_selection = TRUE)
gc$train_error
gc$lambda
sd(Y)
plot(gc)
gc$lambda
```

You can use the following example code to run the subgraph selection penalty using your pre-fixed lambda through 5-fold cv:

```R 
gc <- graphclass(X = X, Y = Y, type = "intersection", lambda=1e-5 ,rho = 1, gamma = 1e-5, folds = 5, lambda_selection = FALSE)
gc$train_error
gc$lambda
sd(Y)
plot(gc)
gc$lambda
```
