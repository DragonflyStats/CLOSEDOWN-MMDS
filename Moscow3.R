
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


###########################################

# Method randomForest works best when there are few variables and when factors are used
# rather than continuous variables. The whatsMax function is used to create a data frame of
# containing a list of the species of maximum basal area, and two other related variables.
