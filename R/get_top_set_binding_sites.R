#!/usr/bin/env Rscript
# This script takes the sets_to_score.txt output of R/get_top_3_distinct_sets.R and returns target genome binding sites of the sets.

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  args[1] <- "swga_results/like_nau_try_2"  # default workdir
  args[2] <- "sets_to_score.txt"  # default infile name
  args[3] <- "sets_to_score_target_binding_sites.txt"  # default outfile name
}
WORKDIR <- args[1]
INFILE <- paste(WORKDIR, args[2], sep = "/")
OUTFILE <- paste(WORKDIR, args[3], sep = "/")

# Load infile
paths_sets_to_score <- read.delim(file = INFILE, header = F, col.names = "path")

# Load primer binding sites in target for each set
is_first <- T
for (set_path in paths_sets_to_score$path) {
  primer_bedfiles <- list.files(set_path)
  primer_bedfiles <- primer_bedfiles[primer_bedfiles != "whole_set.bed"]

  for (bedfile in primer_bedfiles) {
    bed <- read.delim(
      file = paste0(set_path, "/", bedfile),
      skip = 1,
      header = F,
      col.names = c("ref", "primer_start", "primer_end"),
      sep = ""
    )
    bed$primer_seq <- gsub(x = bedfile, pattern = ".bed", replacement = "")
    bed$set_path <- set_path
    if (is_first) {
      primer_sites <- bed
      is_first <- F
    } else {
      primer_sites <- rbind(primer_sites, bed)
    }
  }
}

# Write out primer binding site info
write.table(
  x = primer_sites,
  file = OUTFILE,
  row.names = F
)

