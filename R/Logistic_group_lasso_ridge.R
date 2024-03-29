# Fits a logistic group lasso and returns list with optimal value and information
logistic_group_lasso_ridge <- function(X,Y, D, lambda1, lambda2, gamma,
                                 jobID = "NULL",verbose = F,
                                 beta_start, b_start, 
                                 NODES, MAX_ITER, 
                                 CONV_CRIT = 1e-06, MAX_TIME = Inf, folds= 5 , lambda_selection=TRUE) {
  
  
 require(gglasso) 
nnminus1 = dim(X)[2]
p = 0.5 + sqrt(1+8*nnminus1)/2
pminus = p-1
optimal = list()

index = NA
for (i in 1:pminus) {
  temp =rep(i,i)
  index = c(index, temp)
    
}
index= index[2:length(index)]

if  (lambda_selection==TRUE) {   
 gr_cv =  cv.gglasso(x=X, y=Y, group=index, 
                    loss='ls', pred.loss='L2', nlambda = 1,
                    intercept = T, nfolds=folds , lambda=lambda2 )

coefs = coef(gr_cv$gglasso.fit, s = gr_cv$lambda.min)
optimal$best_b =  coefs[1]
optimal$best_beta = coefs[2:length(coefs)]
optimal$lambda = gr_cv$lambda.min
  

}
  
 if  (lambda_selection==FALSE) { 
 print("here3")
   
   gr_cv  =   gglasso(x=X, y=Y, group=index, 
                    loss='ls', nlambda = 1,
                    intercept = T , lambda=lambda2 ) 

optimal$best_b = gr_cv$b0
optimal$best_beta = gr_cv$beta
 optimal$lambda =   gr_cv$lambda

 }
  


  
  return(optimal)
}
