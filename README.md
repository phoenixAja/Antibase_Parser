# Antibase Parser

###Introduction:
>This guide is designed to help you use the AntiBase Parser R Script to analyze LCMS data. 
>The XCMS Bioconductor package was used to analyze LCMS data (PDF attached). 
>The purpose of this script is to streamline the process of analyzing LCMS files and comparing resulting masses against AntiBase in order to prioritize hits.

###File Input:
>Files containing LCMS data must be in either netCDF, mzXML, or mzData files, (However only netCDF files have been used in testing this script thus far).

###Antibase Input:
>The Antibase output file containing all valuable information for each compound found in Antibase 2013 is included in antibase_tableout.csv. Store this in the same location as the LCMS files to be analyzed along with the Antibase_parser.R script.
The files to be analyzed need to be in a format following this example:
+ **EX: WMMC370_A_F401.CDF**
>The most important part of naming is that the F4 (or F1, F2, F3) is separated by an underscore separating it from the strain name (so that wells can be correctly identified).
