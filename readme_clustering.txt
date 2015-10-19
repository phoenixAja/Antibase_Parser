To run clustering script

requires libraries xcms pvclust

Step One: Take note of where your directory is of cdf files to be analyzed.
Step Two: If you are on Windows, Find your Rscript.exe file, the path will look something like:
	/c/Program\ Files/R/R-3.2.X/bin/Rscript.exe
	**where R-3.2.X is your version of R which is installed

Step Three: Call the script on the command line:
	For windows:
		/c/Program\ Files/R/R-3.2.X/bin/Rscript.exe Path/to/cdf/folder "name of graph"
	For Mac/Linux:
		Rscript Path/to/cdf/folder "name of graph"

Extra Linux commands for help:
to find R version:
	R --version
to find full path:
	pwd

