#Author Chris Thomas
## THIS SCRIPT GENERATES Marine Streptomyces STRAINS CLUSTER


library(xcms)
library(pvclust)

# command line arguments
args <- commandArgs(trailingOnly = TRUE)
myDir = args[1]
setwd(myDir)

run_xcms <- function() {
  xset <- xcmsSet(scanrange= c(245, 1685))
  xsg1 <- group(xset, method = "mzClust", mzppm = 20, mzabs =0, minsamp =3, minfrac =0)
  xsg2 <- fillPeaks(xsg1)
  values <- groupval(xsg2, value = "into")
  for (r in 1:ncol(values))
    values[,r] <- (values[,r] / sum(values[,r]))
  fit <-pvclust(values, method.dist = "cor", nboot=1000)
  plot(fit, main = "Hierarchal Cluster of Marine Streptomyces", print.pv = FALSE, print.num=FALSE)
}

run_xcms()
