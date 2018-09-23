
install.packages("yaImpute")
library(yaImpute)
library(magrittr)
library(dplyr)

data(iris)
# form some test data
refs = sample(rownames(iris),50)
IDs  = c(refs,setdiff(rownames(iris),refs))

print(length(refs)) # training set
print(length(IDs))  # full set 


x <- iris[,1:3] # Sepal.Length Sepal.Width Petal.Length
y <- iris[refs,4:5] # Petal.Width Species

print(head(x,3))
print(head(y,3))
# build a yai object using mahalanobis


mal <- yai(x=x,y=y,method="mahalanobis")
head(mal$yRefs,3)
head(mal$xRefs,3)

# output a data frame of observed and imputed values
# of all variables and observations.
impute(mal) %>% head(4)
impute(mal) %>% tail(4)


rownames(impute(mal))
length(rownames(impute(mal)))

malImp=impute(mal,ancillaryData=iris) 

malImp <- malImp %>% mutate(IDs = as.factor(rownames(malImp) )) %>% select(IDs,everything())




malImp %>% head(5)
malImp %>% tail(5)


malImp <- malImp %>% mutate(IDs =as.numeric(IDs)) %>% arrange(IDs) 

malImp %>% head(10)


table(malImp[,10],malImp[,9])

plot(malImp)
