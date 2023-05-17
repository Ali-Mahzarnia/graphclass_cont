
Welcome to the manual of the "graphclass_cont" repository! This repository is a modified version of the "graphclass" R package, which includes new features for incorporating continuous outcome Y and controlling for a number of folds by assigning folds = x and pre-choosing the lambda or letting the system choose it (lambda_selection = TRUE or FALSE). In addition, train_error and test_errors are associated with in sample and out of sample RMSEs.

Installation:
To install this package, please run the following line in R and make sure that the dependencies, such as "gglasso", are installed:

```R  
library(devtools)
install_github("Ali-Mahzarnia/graphclass_cont")
```

Example code:
In this example we use the "::" operator instead of "library(graphclass)". This operator is more memory effieicent and provides flexibility when using similar packages. Once the package is successfully installed, you can use the following example code to run the subgraph selection penalty using the system to choose the lambda through 3-fold cv:

```R 
set.seed(123)


n = 500 # sample size
p = 5 # dimension of connectomes (p * p )
ppminus1by2 = p*(p-1)/2 # length of vectorized connectome

x = matrix( NA, n, ppminus1by2   ) # vectorized data

true_beta = c( rep(10,1), rep(0,2), rep( 30,3 ) ,rep(0,4))


graphclass::plot_adjmatrix(true_beta) # plot of beta


beta_matrix =graphclass:: get_matrix(true_beta)




y = NA
for (i in 1:n) {
  x_i = rnorm(ppminus1by2) # generate random numbers for matrix
    scores = t(x_i)%*%true_beta +  rnorm(1) # multiply x by true beta
  y = c(y,scores) # concatenate with previous set of y
  x[i,] = x_i # concatenate with previous set of x_i
}
y = y [2: length(y)]  # remove the first NA



gc = graphclass::graphclass(X = x, Y = y, type = "intersection", 
                rho = 1, gamma = 1e-5, folds = 10, lambda_selection = T)

gc$train_error # training RMSE 
sqrt(mean((gc$Yfit-y)^2)) # computing RMSE manually
sd(y) # compare it to standard deviation of y

gc$active_nodes

plot(gc) # plot

gc$nonzeros_percentage # computing percentage of non sparse beta
mean(gc$beta!=0) # computing percentage of non sparse beta manually 

gc$lambda # the chosen lambda

```

You can use the following example code to run the subgraph selection penalty using your pre-fixed lambda through 5-fold cv:

```R 
gc.fit <- graphclass::graphclass(X = x, Y = y, type = "intersection", lambda=gc$lambda ,rho = 1, gamma = 1e-5, folds = 5, lambda_selection = FALSE)
gc.fit$train_error
gc.fit$lambda
sd(y)
plot(gc.fit)
gc.fit$lambda
```
