
install.packages(c("yaImpute","fastICA"))
library(yaImpute)
library(fastICA)

suppressWarnings(library(randomForest))
suppressWarnings(library(dplyr))
suppressWarnings(library(magrittr))



data(MoscowMtStJoe)

dim(MoscowMtStJoe)


x <- MoscowMtStJoe[, c("EASTING", "NORTHING", "ELEVMEAN", "SLPMEAN", "ASPMEAN", "INTMEAN", "HTMEAN", "CCMEAN")]
x[, 5] <- (1 - cos((x[, 5] - 30) * pi/180))/2
names(x)[5] = "TrASP"



y <- MoscowMtStJoe[, c(1, 9, 12, 14, 18)]


head(x,3)

head(y,3)

mal <- yai(x = x, y = y, method = "mahalanobis")
 #summary(mal)

msn <- yai(x = x, y = y, method = "msn")
# summary(msn)

gnn <- yai(x = x, y = y, method = "gnn")
# summary(gnn)

ica <- yai(x = x, y = y, method = "ica")
# summary(ica)

y2 <- cbind(whatsMax(y[, 1:4]), y[, 5])
names(y2) <- c("MajorSpecies", "BasalAreaMajorSp", "TotalBA")


rf <- yai(x = x, y = y2, method = "randomForest")
head(y2)

plot(rf)

plot(rf, vars = yvars(rf))


rfImp <- impute(rf, ancillaryData = y)
rmsd <- compare.yai(mal, msn, gnn, rfImp, ica)


apply(rmsd, 2, mean, na.rm = TRUE)
plot(rmsd)

data(MoscowMtStJoe)
# get the basal area by species columns
yba <- MoscowMtStJoe[,1:17]
ybaB <- whatsMax(yba,nbig=7) # see help on whatsMax



ba <- cbind(ybaB,TotalBA=MoscowMtStJoe[,18])
x <- MoscowMtStJoe[,37:64]
x <- x[,-(4:5)]
rf <- yai(x=x,y=ba,method="randomForest")
yaiVarImp(rf)


keep=colnames(yaiVarImp(rf,plot=FALSE,nTop=9))
newx <- x[,keep]
rf2 <- yai(x=newx,y=ba,method="randomForest")
yaiVarImp(rf2,col="gray")
compare.yai(rf,rf2)
