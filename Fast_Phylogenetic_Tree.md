# Combine files to do an alignment and after a FastTree (usefull to proposals, or obtain fast results)

cat fastaX.fna fastaY.fna fastaZ.fna > combined_fastaXYZ.fna

# We can use for exaple: Clustal Omega
mamba install clustalo -c bioconda 
clustalo --help

clustalo -i combined_fastaXYZ.fna -o combined_fastaXYZ.aln –force

# Use BioEdit, or MView to visualize alignments.
Also you can use R, or Pthon to visualize it directly in the terminal

# Use the command more
# example: 
more combined_fastaXYZ.aln

# Now that we have our multi-sequence alignment file we can create a phylogeny using a program called FastTree. 
# As the name suggests, this program is quite fast. Early phylogenic estimation programs were very computaionally intense and took a very long time to finish (many STILL are). 
# But there are some new methods like FastTree that speed things up.

# After the alignment, you can make a first tree using FastTree Software:
mamba install fasttree -c bioconda 
fasttree -nt combined_fastaXYZ.aln > combined_fastaXYZ.nwk

# Use the command more to see your tree:
more combined_fastaXYZ.nwk

# Visualize your tree
# Use FigTree or iTOL an visualize it (
You can root it directly in iTOL or FigTree (you also can root it before by coding.

READY TO EDIT YOUR FIRST PHYLOGENETIC TREE
