# Antibase Parser
Phoenix Logan

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

###Running the Script:
>General Notes: This script is designed to run on R version 3.2.0, but any current version of R should work. You will also need to install the package for xcms via the R console (once R is installed) by using the command install.packages(“xcms”) see figure 1 to the right for further information.

###Different Computing Enviornments:
> + Option 1. to run the script on windows open the command prompt, first you need to find teh Rscript.exe file, usually this is in a location similar to:
_/c/Program\ Files/R/R-3.2.X/bin/Rscript.exe **where R-3.2.X is your current version of R_
> Next, you need to navigate to directory with LCMS data to analyze, and enter: /c/Program\ Files/R/R-3.2.X/bin/Rscript.exe    Antibase_parser_v2.R 
 
> + Option 2. If you are using Mac OS or Linux (any flavor) use this following command in terminal: Rscript Antibase_parser_v2.R
 _IMPORTANT: You will need to put the antibase_tableout.csv in the same directory as the LCMS files, along with Antibase_parser_v2.R script._

>**“C:\Program Files\R\R-3.2.0\bin\Rscript.exe” Antibase_parser.R**
Where the path in quotes is the file path to the R.exe script described above. You must put this file in the same directory as the LCMS file, the antibase_tableout.csv, and Antibase_parser_v2.R files.

###Understanding Script Output:
>This script will output data in 2 formats, one will be all the peaks detected with the LCMS prior to processing (file_LCMS_RawData.csv) and the other file will contain the processed data once matched against Antibase, with all masses that matched one or less times against Antibase (file_two_or_less_ABMatch.csv). The file prefix will be the netCDF file name prefix to easily identify which output file matches to a certain netCDF file.

> Column Names (for Raw Data):
+ m/z : weighted (by intensity) mean of peak m/z
+ mzmin : m/z of minimum step
+ mzmax : m/z of maximum step
+ rt : retention time of peak midpoint
+ rtmin : leading edge of peak retention time
+ rtmax : trailing edge of peak retention time
+ into : integrated area of original (raw) peak
+ intf : integrated area of filtered peak
+ maxo : maximum intensity of original (raw) peak
+ maxf : maximum intensity of filtered peak
+ i : rank of peak identified in merged EIC
+ sn : signal to noise ratio of the peak
+ Table 1: LCMS_RawData file output

> Column Names (Parsed Data):
+ Masses : Masses processed from raw LCMS data that had one or fewer matches against AntiBase.
+ Retention : Retention time of masses matched one or less time against AntiBase.
+ Fractions : Which fraction mass falls into based on its retention time.
+ Wells : Well ID formulated from the retention time, fractions number, and input file name
+ Times_matched : How many times compound was matched against Antibase
+ Names : Name of any matched natural product (if any exist).
+ Sources : which source the natural product matched originates from
+ Type_match : Whether the match of the mass to antibase was a result from the mass alone, the mass minus a hydrogen ion (m –H) or mass minus a sodium ion (m – Na)

###Further Questions or Concerns:
>I am expecting some issues to occur when operating this script on a new computer (because script has only been tested on one computer/ only one OS thus far ). Please feel free to email me at Phoenix@PhoenixLogan.net if you have any questions / trouble shooting help.

###Useful Websites:
> + [Information regarding R programming Setup:](https://cran.r-project.org/doc/manuals/r-release/R-admin.html)
> + [Information about Bioconductor package XCMS:](http://bioconductor.org/packages/release/bioc/html/xcms.html)
