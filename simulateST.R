#!/usr/local/bin/Rscript
# simulate species typing output by writing subsets of the whole data to file
PKGs <- c("data.table", "dplyr", "optparse")
  invisible(
    lapply(PKGs, function(x) {suppressPackageStartupMessages(library(x, character.only = TRUE)) })
  )

# options are input file and wait time in secs
option_list <- list(
  make_option(c("-f", "--file"), type = "character", default = NULL, 
              help="file with the whole output of jsa.np.rtSpeciesTyping [default = %default]"),
  make_option(c("-o", "--outfile"), type = "character", default = "test.tsv",
              help = "output file, will be overwritten each x seconds [default = %default]" ),
  make_option(c("-s", "--seconds"), type = "integer", default = 3,
              help = "wait time in seconds between sending the data from each cycle [default = %default] ")
  )
opt_parser <- OptionParser(option_list = option_list,
                           usage = "usage: simulateST.R [options]",
                           epilogue = "A. Angelov | 2019 | aangeloo@gmail.com")
opt <- parse_args(opt_parser)
  

simulateST <- function(infile, outfile, interval) {
  df <- fread(infile)
  dfl <- split(df, df$step)
  
  for (i in 1:length(dfl)) {
    
    Sys.sleep(interval)
    fwrite(dfl[[i]], file = outfile)
    cat("cycle #", i, "of", length(dfl), "written to file","\n")
  }
  
}
cat("Program started, cycles will be written to", opt$outfile, "each", opt$seconds, "seconds \n")
simulateST(opt$file, opt$outfile, opt$seconds)
