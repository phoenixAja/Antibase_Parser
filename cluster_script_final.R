#Author Chris Thomas Phoenix Logan
## THIS SCRIPT GENERATES Marine Streptomyces STRAINS CLUSTER


library(xcms)
library(pvclust)

# command line arguments
# set working directory
args <- commandArgs(trailingOnly = TRUE)
myDir = args[1]
setwd(myDir)

run_xcms <- function(plot_title) {
  # Analyze data and return graph
  xset <- xcmsSet(scanrange= c(245, 1685))
  xsg1 <- group(xset, method = "mzClust", mzppm = 20, mzabs =0, minsamp =3, minfrac =0)
  xsg2 <- fillPeaks(xsg1)
  values <- groupval(xsg2, value = "into")
  
  for (r in 1:ncol(values))
    values[,r] <- (values[,r] / sum(values[,r]))
  fit <-pvclust(values, method.dist = "cor", nboot=1000)
  
  # print png file
  png(file=paste0(plot_title, "png"), units = "in", width=11, height=8.5, res=300)
  plot(fit, main=paste0(plot_title, "Hierarchal Cluster of Marine Streptomyces"), 
       print.pv = FALSE, print.num=FALSE)
  dev.off()
  # print eps file
  setEPS()
  postscript(paste0(plot_title, ".eps"))
  plot(fit, main=paste0(plot_title, "Hierarchal Cluster of Marine Streptomyces"),
       print.pv = FALSE, print.num=FALSE)
  dev.off()
  # print pdf file
  pdf(file = paste0(plot_title, ".pdf"))
  plot(fit, main = paste0(plot_title, "Hierarchal Cluster of Marine Streptomyces"), 
       print.pv = FALSE, print.num=FALSE)
  dev.off()
  
  }

run_xcms(args[2])
