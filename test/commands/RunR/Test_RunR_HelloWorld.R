# R script for corresponding TSTool command file
# - get the working directory from first command line argument
# - output a simple "Hello world" message to a file

# Set working directory
args = commandArgs(trailingOnly=TRUE)
if (length(args)<1) {
  # Working directory was not provided on the command line so use default (works opening in RStudio)
  wd <- getwd()
  cat("Working directory defaulting to: ", wd)
} else {
  # Set working directory from first command line argument
  # Use when run from TSTool or other automated workflow.
  wd <- args[1]
  cat("Working directory from command line: ", wd, "\n")
  setwd(wd)
}

# Print the working director to standard output
cat("Working directory: ", wd, "\n" )

outfile <- "Results/Test_RunR_HelloWorld_out.txt"
cat("Hello world", file=outfile)
