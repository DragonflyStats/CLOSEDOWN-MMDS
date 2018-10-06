
library("yaImpute")
data("iris")
set.seed(1)
refs = sample(rownames(iris), 50)
x <- iris[, 1:3]
y <- iris[refs, 4:5]


Mahalanobis <- yai(x = x, y = y, method = "mahalanobis")
#plot(Mahalanobis)



head(impute(Mahalanobis))
tail(impute(Mahalanobis))
