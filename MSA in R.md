library(seqinr)

# Simple sanity check with a small FASTA file:

rabies <- read.fasta(file = "C:/Users/analorena/xxxx.fas.txt")


#Install packages_Bioconductor FOR ALIGNMENT
library(msa)
library(Biostrings)

# FASTA file
fasta_file <- "rabies"
mySequences <- readDNAStringSet("C:/Users/analorena/xxxx.fas.txt")


# Check the first few sequences
head(mySequences)

library(msa)
# Alignment
alignment <- msa(mySequences)

#Muscle methodology
alignment <- msa(mySequences, method = "Muscle")

# Assuming `sequences` is already read in from your FASTA file
alignment <- msa(mySequences, substitutionMatrix = "DNA")

# Check alignment
print(alignment)

# View alignment 
consensus <- msaConsensusSequence(alignment)
print(consensus)

library(ggplot2)
library(ggmsa)
ggmsa("C:/Users/analorena/xxxx.fas.txt", seq_name = TRUE)

# Plot the alignment 
msaPrettyPrint(alignment, output="pdf", file="alignment_output.pdf")
