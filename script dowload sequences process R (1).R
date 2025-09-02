install.packages("rentrez")
library(rentrez)

# API KEY VT
set_entrez_key("27f406d7b920408fd5147371a4c2147dc008")

# FILTRING
query <- "Rabies virus[Organism] AND Glyphonycteris[Host] AND complete genome[Title] AND 2011:2024[Publication Date]"
search_results <- entrez_search(db = "nucleotide", term = query, retmax = 20)
 
# SHOW RESULTS
print(search_results$count)

# SHOW IDs OF SEQUENCES
print(search_results$ids)

# DOWLOAD SEQUENCES FASTA
fasta_data <- entrez_fetch(db = "nucleotide", id = search_results$ids, rettype = "fasta", retmode = "text")

# SAVE SEQUENCES IN A FILE
writeLines(fasta_data, "rabies_Lasiurus_USA_complete_genomes.fasta")


