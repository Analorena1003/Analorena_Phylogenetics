
# Read the FASTA file
fasta_file <- "C:/Users/analorena/Documents/ESCOBAR LAB/EVOLUTION Rabies Review paper/COMPLETE GENOME/alignment Complete genomes.fasta"
fasta_lines <- readLines(fasta_file)

# Count lines that start with ">"
num_sequences <- sum(grepl("^>", fasta_lines))

# Print the number of sequences
cat("Number of sequences in the file:", num_sequences, "\n")


# Modify the headers
modified_fasta <- sapply(fasta_lines, function(line) {
  if (grepl("^>", line)) {
    # Extract the GenBank ID and append "_raccoon"
    genbank_id <- sub("^>(\\S+).*", "\\1", line)
    return(paste0(">", genbank_id, "_raccoon"))
  } else {
    # Keep sequence lines unchanged
    return(line)
  }
})

# Save the modified FASTA file
output_file <- "C:/Users/analorena/Documents/raccoon_rabies_sequences_modified.fasta"
writeLines(modified_fasta, output_file)

cat("Modified FASTA file saved as:", output_file, "\n")

getwd()



