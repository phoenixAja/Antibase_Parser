#Author: Phoenix Logan

#load the xcms 
library(xcms)

#read in the antibase information and extract masses from StructCalc column
AB_lst <- read.csv("antibase_tableout.csv", stringsAsFactors = FALSE)
AB_mass <- AB_lst$StructCalc
#strip out the trailing zeros
StructCalc <- as.numeric(sub("[ ][.]+", "", AB_mass))
StructCalc[is.na(StructCalc)] <- 0 
StructCalc <- as.numeric(StructCalc)

#compare all the masses against antibase and return a dataframe of all mass matches
positions <- c()
compare_masses <- function(mass_lst){
  for (i in seq_along(mass_lst)) {
    positions <- c(positions, which(abs(StructCalc - mass_lst[i]) < 0.01))
  }
  return(AB_lst[positions,])
}

#convert scan time to retention time
get_retentions <- function(retention){
  ret_actual <- as.numeric(retention/60)
}

remove_duplicates <- function(mass){
  num_masses <- which(abs(mass_lst - mass) <= 0.1)
  masses_combined <- mass_lst[num_masses]
  mass_final <- sum(masses_combined)/length(masses_combined)
  return(mass_final)
}

#returns the fraction numbers
get_fractions <- function(rt){
  fraction <- vector(mode= "numeric", length=1)
  if (rt < 3.2){
    fraction <- 0
  }
  if (3.2<rt && rt <= 4.2){
    fraction <- 1
  }
  if (4.2 < rt && rt <= 5.2){
    fraction <- 2
  }
  if (5.2 < rt && rt <= 6.2){
    fraction <- 3
  }
  if (6.2 < rt && rt <= 7.2){
    fraction <- 4
  }
  if (7.2 < rt && rt <= 8.2){
    fraction <- 5
  }
  if (8.2 < rt && rt <= 9.2){
    fraction <- 6
  }
  if (9.2 < rt && rt <= 10.2){
    fraction <- 7
  }
  if (11.2 < rt && rt <= 12.2){
    fraction <- 8
  }
  if (12.2 < rt && rt <= 13.2){
    fraction <- 9
  }
  if (13.2 < rt && rt <= 14.2){
    fraction <- 10
  }
  if (14.2 < rt && rt <= 15.2){
    fraction <- 11
  }
  if (15.2 < rt && rt <= 16.2){
    fraction <- 12
  }
  if (16.2 < rt && rt <= 17.2){
    fraction <- 13
  }
  if (17.2 < rt && rt <= 18.2){
    fraction <- 14
  }
  if (18.2 < rt && rt <= 19.2){
    fraction <- 15
  }
  if (19.2 < rt && rt <= 20.2){
    fraction <- 16
  }
  if (20.2 < rt && rt <= 21.2){
    fraction <- 17
  }
  if (21.2 < rt && rt <= 22.2){
    fraction <- 18
  }
  if (22.2 < rt && rt <= 23.2){
    fraction <- 19
  }
  if (23.2 < rt && rt <= 24.2){
    fraction <- 20
  }
  if (24.2 < rt ){
    fraction <- 21
  }
  return(fraction)
}


#find the name matches in the mass matches
find_names <- function(mass){
  pos <- which(abs(StructCalc - mass) < 0.01)
  positions_na <- which(abs(StructCalc - (mass-22.989769)) < 0.01)
  positions_H <- which(abs(StructCalc - (mass - 1.00794)) < 0.01)
  if (length(pos) == 0 && length(positions_H) ==0 && length(positions_na) ==0){
    nm <- "no matched names"
  }else{
    positions <- unlist(c(pos, positions_na, positions_H))
    ab_mtch <- AB_lst[positions,]
    nm <- as.vector(ab_mtch$Name)
  }
  nm <- paste(nm, collapse = "|")
  return(nm)
}

#find the sources of each mass match
find_sources <- function(mass){
  pos <- which(abs(StructCalc - mass) < 0.01)
  positions_na <- which(abs(StructCalc - (mass-22.989769)) < 0.01)
  positions_H <- which(abs(StructCalc - (mass - 1.00794)) < 0.01)
  if (length(pos) == 0 && length(positions_H) ==0 && length(positions_na) ==0){
    nm <- "no matched sources"
  }else{
    positions <- unlist(c(pos, positions_na, positions_H))
    ab_mtch <- AB_lst[positions,]
    nm <- as.vector(ab_mtch$Sources)
  }
  nm <- paste(nm, collapse = "|")
  return(nm)
}


#find the wells correspoinding to the retention times
find_wells <- function(fraction, file_name){
  file_splt <- strsplit(file_name, "[_0]")
  fn <- unlist(file_splt)
  F1 <- grep("F1", fn)
  F2 <- grep("F2", fn)
  F3 <- grep("F3", fn)
  F4 <- grep("F4", fn)
  if (0 < length(F1)){
    if (0 <= fraction && fraction <= 10){
      well <- paste("A", as.character(fraction + 1))
    }
    if (10 < fraction && fraction <= 21){
      if (fraction == 11){
        fn <- 11
      }
      if (fraction == 12){
        fn <- 10
      }
      if (fraction == 13){
        fn <- 9
      }
      if (fraction == 14){
        fn <- 8
      }
      if (fraction == 15) {
        fn <- 7
      }
      if (fraction ==16){
        fn <- 6
      }
      if (fraction ==17){
        fn <- 5
      }
      if (fraction ==18){
        fn <- 4
      }
      if (fraction ==19){
        fn <- 3
      }
      if (fraction ==20){
        fn <- 2
      }
      if (fraction ==21){
        fn <- 1
      }
      well <- paste("B", as.character(fn))
    }
  }
  if (0 < length(F2)){
    if (0 <= fraction && fraction <= 10){
      well <- paste("C", as.character(fraction + 1))
    }
    if (10 < fraction && fraction <= 21){
      if (fraction == 11){
        fn <- 11
      }
      if (fraction == 12){
        fn <- 10
      }
      if (fraction == 13){
        fn <- 9
      }
      if (fraction == 14){
        fn <- 8
      }
      if (fraction == 15) {
        fn <- 7
      }
      if (fraction ==16){
        fn <- 6
      }
      if (fraction ==17){
        fn <- 5
      }
      if (fraction ==18){
        fn <- 4
      }
      if (fraction ==19){
        fn <- 3
      }
      if (fraction ==20){
        fn <- 2
      }
      if (fraction ==21){
        fn <- 1
      }
      well <- paste("D", as.character(fn))
    }
  }
  if (0 < length(F3)){
    if (0 <= fraction && fraction <= 10){
      well <- paste("E", as.character(fraction + 1))
    }
    if (10 < fraction && fraction <= 21){
      if (fraction == 11){
        fn <- 11
      }
      if (fraction == 12){
        fn <- 10
      }
      if (fraction == 13){
        fn <- 9
      }
      if (fraction == 14){
        fn <- 8
      }
      if (fraction == 15) {
        fn <- 7
      }
      if (fraction ==16){
        fn <- 6
      }
      if (fraction ==17){
        fn <- 5
      }
      if (fraction ==18){
        fn <- 4
      }
      if (fraction ==19){
        fn <- 3
      }
      if (fraction ==20){
        fn <- 2
      }
      if (fraction ==21){
        fn <- 1
      }
      well <- paste("F", as.character(fn))
    }
  }
  if (0 < length(F4)) {
    if (0 <= fraction && fraction <= 10){
      well <- paste("G", as.character(fraction + 1))
    }
    if (10 < fraction && fraction <= 21){
      if (fraction == 11){
        fn <- 11
      }
      if (fraction == 12){
        fn <- 10
      }
      if (fraction == 13){
        fn <- 9
      }
      if (fraction == 14){
        fn <- 8
      }
      if (fraction == 15) {
        fn <- 7
      }
      if (fraction ==16){
        fn <- 6
      }
      if (fraction ==17){
        fn <- 5
      }
      if (fraction ==18){
        fn <- 4
      }
      if (fraction ==19){
        fn <- 3
      }
      if (fraction ==20){
        fn <- 2
      }
      if (fraction == 21){
        fn <- 1
      }
      well <- paste("H", as.character(fn))
    }
  }
  return(well)
}

run_program <- function(file){
  path = file
  xraw <- xcmsRaw(file)
  p <- findPeaks(xraw)
  dataframe_p <- as.data.frame(p, stringsAsfactors=FALSE)
  masses_p <- as.numeric(dataframe_p$mz)
  s_n <- as.numeric(dataframe_p$sn)
  retention_lst <- as.numeric(dataframe_p$rt)
  
  all_match_df <- compare_masses(masses_p)
  
  masses <- c()
  rt <- c()
  times_matched <- c()
  type_match <- c()
  for (i in seq_along(masses_p)){
    pos_num <- which(abs(StructCalc - masses_p[i]) < 0.01)
    positions_na <- which(abs(StructCalc - (masses_p[i]-22.989769)) < 0.01)
    positions_H <- which(abs(StructCalc - (masses_p[i] - 1.00794)) < 0.01)
    if (length(pos_num) <= 2 | length(positions_na) <= 2 | length(positions_H) <= 2){
      sum_matches <- sum(length(pos_num), length(positions_na), length(positions_H))
      if (sum_matches <= 2){
        masses <- c(masses, masses_p[i])
        rt = c(rt, retention_lst[i])
        times_matched <- c(times_matched, sum_matches)
        types_int <- c()
        if(0 < length(pos_num)){
          types_int <- c(types_int, "m")
        }
        if( 0 < length(positions_na)){
          types_int <- c(types_int, "m-Na")
        }
        if ( 0 < length(positions_H)){
          types_int <- c(types_int, "m-H")
        }
        type_match <- c(type_match, (paste(types_int, collapse= " ")))
      }
    }
  }
  
  retention_times <- sapply(rt, get_retentions)
  fractions <- sapply(retention_times, get_fractions)
  names <- unlist(sapply(masses, find_names))
  sources <- unlist(sapply(masses, find_sources))
  wells <- sapply(fractions, find_wells, file_name = file)
  
  results_df <- cbind(masses, retention_times, fractions, wells, times_matched, names, sources, type_match)
  new_results_df <- subset(results_df, results_df[,3] != 21)
  file_name <- strsplit(file, "[.]")[1][[1]][1]
  
  write.csv(new_results_df, file= paste0(file_name,"_two_or_less_ABMatch.csv"))
  #write.csv(all_match_df, file = paste0(file_name,"_allMatches.csv") )
  write.csv(dataframe_p, file = paste0(file_name, "_LCMS_RawData.csv"))
  
}

file_lst <- list.files(".", pattern=".CDF", recursive = TRUE)

sapply(file_lst[], run_program)

