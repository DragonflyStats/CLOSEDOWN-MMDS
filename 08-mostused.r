
install.packages("yaImpute")
library(yaImpute)

suppressWarnings(library(dplyr))
suppressWarnings(library(magrittr))

data(iris)
# form some test data
refs=sample(rownames(iris),50)


x <- iris[,1:3] # Sepal.Length Sepal.Width Petal.Length



y <- iris[refs,4:5] # Petal.Width Species
# build a yai object using mahalanobis

mal <- yai(x=x,y=y,method="mahalanobis")


mostused(mal,kth=1) %>% head(10)
