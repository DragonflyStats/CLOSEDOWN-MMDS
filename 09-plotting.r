
09-`plotting`
=================
Provides a matrix of plots of observed verses imputed values for variables in an object created by
impute.yai, which are of class c("impute.yai","data.frame").


install.packages("yaImpute")
library(yaImpute)


data(iris)
# form some test data
refs=sample(rownames(iris),50)
x <- iris[,1:3] # Sepal.Length Sepal.Width Petal.Length
y <- iris[refs,4:5] # Petal.Width Species


mal <- yai(x=x,y=y,method="mahalanobis")
malImp=impute(mal,newdata=iris)


plot(malImp)
