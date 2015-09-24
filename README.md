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

###Running the Script:
>General Notes: This script is designed to run on R version 3.2.0, but any current version of R should work. You will also need to install the package for xcms via the R console (once R is installed) by using the command install.packages(“xcms”) see figure 1 to the right for further information.

###Different Computing Enviornments:
> + Option 1. to run the script on windows open the command prompt, navigate to directory with LCMS data to analyze, and enter: R <Antibase_parser.R> AB_OUT.out
 _Antibase_parser.R Script (recommended to be in the same directory as the LCMS files to be analyzed)._
 
> + Option 2. If you have Cygwin installed or are using Mac OS or Linux (any flavor) use this following command in terminal: R CMD BATCH Antibase_mass_parser.R
 _IMPORTANT: You will also need to put the R.bat script in the same directory as the LCMS files, along with Antibase_parser.R script, and antibase_tableout.csv (Directions on creating the R.bat script file are below)._

>**Creating the R.bat script file:**
>The purpose of this file is to tell the R program where the R.exe file is. Which on windows is in the Program Files Directory: _Example for Windows: “C:\Program Files\R\R-3.2.0\bin\R.exe”_

>To create the R.bat file, open your favorite text editor (Vim, emacs, Notepad++, Nano) and write this line at the top of your script:

>**“C:\Program Files\R\R-3.2.0\bin\R.exe” CMD BATCH Antibase_parser.R**
Where the path in quotes is the file path to the R.exe script described above. You must put this file in the same directory as the LCMS file, the antibase_tableout.csv, and Antibase_parser.R files.

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
