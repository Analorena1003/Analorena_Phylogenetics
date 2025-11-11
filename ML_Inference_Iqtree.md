## Let's practice phylogenetic inference using IQTree
#First, let's infer a tree topology from alignment using thw Jukes-Cantor (JC) substitution model.

iqtree2 -s youralignment.fa -m JC -bb 1000
iqtree-2.3.6-Linux-intel/bin/iqtree2 iqtree2 -s youralignment.fa -m JC -bb 1000

# What do these command arguments represent?
Represents the models to infer maximum-likelihood. Some commands you can use to select the best model. Or you can directly select what model do you want to use. For example: jModelTest/ProtTest. Or some commands you can directly put the bootstrap values.

# So the arguments -m JC -bb 1000 represents that I want to use JC model with 1000 replicates of bootstrap.
# Now, let's repeat the analysis under the general time reversible (GTR) model.

iqtree2 -s youralignment.fa -m GTR -bb 1000
mkdir JC to create JC model directory
mv youralignment.fa* JC 

# Question : Did the tree topology change under GTR vs. JC? How about branch lengths? Not, the topology is the same, but the branch lengths can changes.

# Next, we are going to perform model selection, which means finding a substitution model that better fits to our data. Once the best model is identified, the tree inference will proceed using that model.

iqtree2 -s youralignment.fa -m TEST -bb 1000

# What is the best fitting model?
# Now, repit the tree inference using the best model based on your data
