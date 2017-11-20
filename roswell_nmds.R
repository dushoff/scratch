
# Test how metric NMDS is

#######################################
#answer: works fine for metaMDS, but glitchy with isoMDS

#load libraries, data
library(vegan)
library(MASS)
data(dune)

#compute distance matrix. Using Morisita-Horn dissimilarity
mdis<-vegdist(dune, method="horn")
#transform
sqdis<-mdis^2
sqrtdis<-(mdis)^1/2

#compute NMDS using MASS function isoMDS
rglr<-data.frame(scores(isoMDS(mdis)))
sqrd<-data.frame(scores(isoMDS(sqdis)))
print(rglr)
print(sqrd)

quit()

sqrrt<-isoMDS(sqrtdis)

#compute using metaMDS from vegan, calls monoMDS by default
rglr2<-data.frame(scores(metaMDS(mdis)))
sqrd2<-data.frame(scores(metaMDS(sqdis)))
sqrrt2<-data.frame(scores(metaMDS(sqrtdis)))


# to compare plots, you may need to rotate. Also, units are meaningless
# so compression is fine.
par(mfrow=c(1,3))
plot(rglr[[1]][,1], rglr[[1]][,2], xlim=c(-.75,.75), ylim=c(-.75,.75),
main="untransformed, iso", xlab="", ylab="")
plot(sqrd[[1]][,1], sqrd[[1]][,2], xlim=c(-.75,.75), ylim=c(-.75,.75),
main="squared, iso", xlab="", ylab="")
plot(sqrrt[[1]][,1], sqrrt[[1]][,2], xlim=c(-.75,.75), ylim=c(-.75,.75),
main="sqrt, iso", xlab="", ylab="")
#these aren't identical

# to compare plots, you may need to rotate. Also, units are meaningless
# so could be compressed.
plot(rglr2[,1], rglr2[,2], xlim=c(-.75,.75), ylim=c(-.75,.75),
main="untransformed, meta", xlab="", ylab="")
plot(sqrd2[,1], sqrd2[,2], xlim=c(-.75,.75), ylim=c(-.75,.75),
main="squared, meta", xlab="", ylab="")
plot(sqrrt2[,1], sqrrt2[,2], xlim=c(-.75,.75), ylim=c(-.75,.75),
main="sqrt, meta", xlab="", ylab="")
#these are fine, but can get squished

#rank correlations are identical, pearsons are close
cor(mdis, sqdis, method="pearson")
cor(mdis, sqdis, method="spearman")
cor(sqdis, sqrtdis, method="pearson")
cor(sqdis, sqrtdis, method="spearman")


