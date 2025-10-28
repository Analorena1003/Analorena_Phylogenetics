library(seqinr)

# Simple sanity check with a small FASTA file:

rabies <- read.fasta(file = "C:/Users/analorena/xxxx.fas.txt")


#Install packages_Bioconductor FOR ALIGNMENT
library(msa)
library(Biostrings)

# FASTA file
fasta_file <- "rabies"
mySequenceFile <- system.file("examples", "exampleAA.fasta", package="msa")
mySequences <- readAAStringSet(mySequenceFile)
mySequences

# Check the first few sequences
head(mySequences)

library(msa)
# Alignment
alignment <- msa(mySequences)

# Assuming `sequences` is already read in from your FASTA file
alignment <- msa(mySequences, substitutionMatrix = "DNA")

# Check alignment
print(alignment)

# View alignment 
consensus <- msaConsensusSequence(alignment)
print(consensus)

library(ggplot2)
library(ggmsa)
protein_sequences <- system.file("extdata", "sample.fasta", package = "ggmsa")
ggmsa("C:/Users/analorena/xxxx.fas.txt", start = 1, end = 20, char_width = 0.5, seq_name = T)+ 
 geom_seqlogo() + 
 geom_msaBar()
ggmsa(mySequences)

# Plot the alignment 
msaPrettyPrint(alignment, output="pdf", file="alignment_output.pdf")n
