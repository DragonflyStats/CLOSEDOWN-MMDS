library(yaImpute)
library(randomForest)


data(MoscowMtStJoe)
# convert polar slope and aspect measurements to cartesian
# (which is the same as Stage's (1976) transformation).
polar <- MoscowMtStJoe[,40:41]
polar[,1] <- polar[,1]*.01 # slope proportion
polar[,2] <- polar[,2]*(pi/180) # aspect radians


cartesian <- t(apply(polar,1,function (x)
{return (c(x[1]*cos(x[2]),x[1]*sin(x[2]))) }))

colnames(cartesian) <- c("xSlAsp","ySlAsp")
########################################

x <- cbind(MoscowMtStJoe[,37:39],cartesian,MoscowMtStJoe[,42:64])
head(x,3)

y <- MoscowMtStJoe[,1:35]
head(y,3)

msn <- yai(x=x, y=y, method="msn", k=1)
# msn

mal <- yai(x=x, y=y, method="mahalanobis", k=1)
# mal

# compare these results using the generalized mean distances..
grmsd(mal,msn)

# the results can be plotted.
plot(mal,vars=yvars(mal)[1:16])

#############################################

# reduce the plant community data for randomForest.
yba <- MoscowMtStJoe[,1:17]
ybaB <- whatsMax(yba,nbig=7) # see help on whatsMax
rf <- yai(x=x, y=ybaB, method="randomForest", k=1)
# build the imputations for the original y's
rforig <- impute(rf,ancillaryData=y)
# compare the results using individual rmsd's
compare.yai(mal,msn,rforig)

###########################################



plot(compare.yai(mal,msn,rforig))
# build another randomForest case forcing regression
# to be used for continuous variables. The answers differ
# but one is not clearly better than the other.
rf2 <- yai(x=x, y=ybaB, method="randomForest", rfMode="regression")
rforig2 <- impute(rf2,ancillaryData=y)
compare.yai(rforig2,rforig)