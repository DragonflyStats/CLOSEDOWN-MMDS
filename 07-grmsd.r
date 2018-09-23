
install.packages("yaImpute")
library(yaImpute)

library(magrittr)
library(dplyr)

data(iris)
set.seed(12345)
# form some test data
refs=sample(rownames(iris),50)


x <- iris[,1:2] # Sepal.Length Sepal.Width
tail(x)
dim(x)

y <- iris[refs,3:4] # Petal.Length Petal.Width
tail(y)
dim(y)

# build yai objects using 2 methods
msn <- yai(x=x,y=y)
mal <- yai(x=x,y=y,method="mahalanobis")
lmFit=lm(as.matrix(y) ~ ., data=x[refs,])

# compute the average distances between observed and imputed (predicted)
grmsd(msn,mal,lmFit)



# use the all variables and observations in iris
# Species is a factor and is automatically deleted with a warning
grmsd(msn,mal,ancillaryData=iris[,1:4])


# here is an example using lm, and another using column
# means as predictions.
impMean <- y
colnames(impMean) <- paste0(colnames(impMean),".o")
impMean <- cbind(impMean,y)
tail(impMean)

dim(impMean)

# set the predictions to the mean's of the variables
impMean[,"Petal.Length"] <- mean(impMean[,"Petal.Length"])
impMean[,"Petal.Width"] <- mean(impMean[,"Petal.Width"])
grmsd(msn, mal, lmFit=lm(as.matrix(y) ~ ., data=x[refs,]), impMean )

# compare to using function rmsd (values match):
msnimp <- na.omit(impute(msn))
grmsd(msnimp[,c("Petal.Length","Petal.Length.o")])
rmsd(msnimp[,c("Petal.Length","Petal.Length.o")],scale=TRUE)
# these are multivariate cases and they don't match
# because the covariance of the two variables is > 0.



grmsd(msnimp)


colSums(rmsd(msnimp,scale=TRUE))/2
# get the vectors and make a boxplot, identify outliers


stats <- boxplot(grmsd(msn,mal,ancillaryData=iris[,-5],rtnVectors=TRUE),
ylab="Mahalanobis distance")


stats$out

