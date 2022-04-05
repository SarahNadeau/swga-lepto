#!/usr/bin/env Rscript
# This script takes the sets output of the swga program and returns the top 3 high-scoring sets that are at least 50% unique.

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  args[1] <- "swga_results/like_nau_try_2"  # default workdir
}
WORKDIR <- args[1]

set_files <- list.files(
  path = WORKDIR,
  pattern = "sets_top_-1_score.txt",
  recursive = T,
  full.names = T
)

print(paste("Finding top sets from", length(set_files), "files."))

for (file in set_files) {
  sets <- read.delim(file = file, stringsAsFactors = F)
  if (nrow(sets) == 0) {
    warning(paste("File", file, "has no sets, skipping."))
    next
  }
  split_path <- strsplit(file, split = "/")[[1]]
  outpath <- paste0(split_path[1:(length(split_path) - 1)], collapse = "/")
  primers_outfile <- paste(outpath, "top_3_distinct_sets.txt", sep = "/")
  primers_outfile_con <- file(primers_outfile, 'a')
  set_idx_outfile <- paste(outpath, "top_3_distinct_set_idxs.txt", sep = "/")
  set_idx_outfile_con <- file(set_idx_outfile, 'a')
  top_set <- strsplit(sets$primers[1], split = ",")[[1]]
  n_sets_found <- 1
  set_size <- length(top_set)
  writeLines(text = sets$primers[1], con = primers_outfile_con)
  writeLines(text = paste0("set_", sets$X_id[1]), con = set_idx_outfile_con)
  print(paste("Finding 3 distinct sets. Set size =", set_size))
  for (i in 1:nrow(sets)) {
    if (n_sets_found == 3) {
      break
    }
    primers <- sets$primers[i]
    set <- strsplit(primers, split = ",")[[1]]
    if (length(setdiff(top_set, set)) > 0.5 * set_size) {
      writeLines(text = primers, con = primers_outfile_con)
      writeLines(text = paste0("set_", sets$X_id[i]), con = set_idx_outfile_con)
      top_set <- c(top_set, set)  # next set must be at least half unique compared to all prev sets saved
      n_sets_found <- n_sets_found + 1
    }
  }
  close(con = primers_outfile_con)
  close(con = set_idx_outfile_con)
}
