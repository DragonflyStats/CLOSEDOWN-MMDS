
install.packages("yaImpute")
library(yaImpute)

suppressWarnings(library(dplyr))
suppressWarnings(library(magrittr))

data(iris)
# form some test data
set.seed(1234)
refs=sample(rownames(iris),50)
x <- iris[,1:3] # Sepal.Length Sepal.Width Petal.Length
y <- iris[refs,4:5] # Petal.Width Species


head(x,3)

head(y,3)

# build a yai object using mahalanobis
mal <- yai(x=x,y=y,method="mahalanobis",k=3)
foruse(mal) %>% head(4) # for references, use is equal to the rowname


foruse(mal,kth=1) %>% head(10) # for references, use is an row to the kth reference.


# get all the choices:
cbind(foruse(mal),foruse(mal,kth=1),foruse(mal,kth=2),foruse(mal,kth=3)) %>% head(10)
