#Author: Phoenix Logan
#Usage: Search antibase for mass matches found with LC MS data and return a .csv
#file with matches 
usr_path <- readline(prompt="enter the full path to the .cdf files")

#read in the cdf files
library(xcms)
path <- "C:/Users/Tim Bugni Lab/Desktop/PL_XCMS/"
c <- xcmsSet(files = path)
m <- group(c)
n <- fillPeaks(m)
values <- groupval(n,value = "into")
head(values)

df_values <- as.data.frame(values)
mass_retention <- row.names(df_values)

extract_masses <- function(x) {
  x_split <- unlist(strsplit(x, "/"))
  masses <- x_split[seq(1,length(x_split),2)]
  return(masses)
}

mass_lst <- unlist(lapply(mass_retention, extract_masses))
mass_lst <- as.numeric(mass_lst)

AB_lst <- read.csv("C:/Users/Tim Bugni Lab/Desktop/antibase_newScripts/Antibase_tableOut.csv")
AB_mass <- AB_lst$Mass

#This function will strip off the g_mol string at the end of each entry to 
#make pasrsing easier
only_masses <- function(x) {
  for (i in 1:length(x)) {
    mass_extract <- vector(mode="character", length= length(x))
    split_x <- strsplit(as.character(x[i]), " ")
    split_mass <- split_x[[1]][1]
    mass_extract[i] <- split_mass
  }
  return(mass_extract)
}

#execute the function of all antibase masses
AB_massLst_stripped <- sapply(AB_mass, only_masses)

#replace all NA values with 0 and set it as a numeric vector
AB_massLst_stripped[is.na(AB_massLst_stripped)] <- 0 
AB_massLst_numeric <- as.numeric(AB_massLst_stripped)

#This loop will compare masses with the antibase list and the user
#input file
match_df <- data.frame()
lower_matches <- data.frame()
#compare_masses <- function(mass_lst){
for (i in seq_along(mass_lst)) {
  positions <- which(abs(AB_massLst_numeric - mass_lst[i]) < 0.01)
  if (length(positions) <= 1){
    lower_matches <- rbind(lower_matches, values[i])
    rownames(lower_matches) <- c(rownames(values[i]))
  }
  rows <- AB_lst[positions,]
  match_df <- rbind(match_df, rows)
}

#this function will extract out all 

#run the function and collect the output
#s <- sapply(mass_lst, compare_masses)

#write the test to an output
write.csv(lower_matches, file="One_or_less_matches3.csv")
write.csv(match_df, file= "match_test_smallRange3.csv")
