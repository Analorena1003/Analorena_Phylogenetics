# Let's infer a phylogenetic tree from multiple sequence alignment (MSA)
# Loggin In
# The first step is to login to the ARC HPC system. In your terminal type:
ssh your_id@owl1.arc.vt.edu
# Example - My case
ssh analorena@owl1.arc.vt.edu

# Download IQTREE program on HPC:
wget https://github.com/Cibiv/IQ-TREE/releases/download/v1.6.12/iqtree-1.6.12-Linux.tar.gz

# Unzip tar.gz-compressed directory using tar command:
tar -xvzf iqtree-1.6.12-Linux.tar.gz

# Navigate to the unzipped folder and explore its contents. Typically, the executable program file (in our case it is the IQTREE program) is in the bin directory. Try to open it by typing:
./iqtree2 -h

# Here . means current directory and the -h argument means "display help page and exit". 
# If a program prints its help page without any warning signs you can assume that it has been correctly installed.

# IQTREE is a very flexible and comprehensive maximum-likelihood-based program that can perform an array of phylogenetic tasks including simulation of MSAs and tree inference. Lets try to simulate MSA of 5 taxa and 5000 bp along a given the tree topology and branch length. 
# First, lets generate a so called newick tree file that specifies tree topology and branch length 
nano tree.nwk 

# Copy and paste this newick representation of the tree(A:0.3544,((B:0.1905,C:0.1328):0.0998,F:2):3.78,D:0.0898);to ourtree.nwkfile in nano. Close nano and checktree.nwkwithless```. Make sure this parenthetic notation of the tree is there.

# Simulate MSA
./iqtree2 --alisim alignment_simulated -m JC -t tree.nwk --length 5000 --out-format fasta

# Estimate a phylogenetic tree form MSA under default IQTREE parameters
./iqtree2 -s alignment_simulated.fa
# Your inferred tree will be in alignment_simulated.fa.treefile file.

# Submitting a job to HPC (READ IT BEFORE)
Our HPC has massive compute power that allows to work with large files, execute computationally intensive tasks and all of it can be done in a parallel manner. Every member of VT community has a free-tier access to ARC HPC. Please refer to the ARC manual https://www.docs.arc.vt.edu/index.html
Our HPC system operates using so called SLURM (Simple Linux Utility for Resource Management). SLURM is an open-source job scheduler and resource manager widely used in HPC environments. It manages and allocates compute resources on clusters or supercomputers, allowing users to submit, monitor, and control jobs efficiently.
To submit a job first you have to develop a submission script. A submission script is a simple text file with .sh extention that contains certain instructions (e.g. number of cores, memory, time duration etc.) for SLURM of how to run your job.

Here are the examples:

Example 1: Single-Node, Single-Core Job

# CODE

#!/bin/bash
#SBATCH -J my_job_name
#SBATCH --account=personal
#SBATCH --partition=normal_q
#SBATCH --nodes=1                # Use 1 node
#SBATCH --ntasks-per-node=1      # Run 1 task on the node
#SBATCH --cpus-per-task=1        # Allocate 1 CPU for the task
#SBATCH --time=00:10:00          # Set a 10-minute time limit
#SBATCH --output=output.txt

# Run the program
my_program_to_run 
One node is used, running one task, which gets one CPU core.
Use Case: Running a simple, single-threaded program (like a basic Python script).

Example 2: Single-Node, Multi-Core Job

# CODE

#!/bin/bash
#SBATCH -J my_job_name
#SBATCH --account=personal
#SBATCH --partition=normal_q
#SBATCH --nodes=1                # Use 1 node
#SBATCH --ntasks-per-node=1      # Run 1 task on the node
#SBATCH --cpus-per-task=4        # Allocate 4 CPUs for the task
#SBATCH --time=00:10:00          # Set a 10-minute time limit
#SBATCH --output=output.txt

# Run the program
my_program_to_run 
One node is used, running one task, but the task has access to 4 CPU cores to execute threads in parallel.
Use Case: Running a multithreaded application (e.g., OpenMP or a Python script using multiprocessing).

Example 3: Multi-Node, Multi-Task Job

# CODE

#!/bin/bash
#SBATCH -J my_job_name
#SBATCH --account=personal
#SBATCH --partition=normal_q
#SBATCH --nodes=2                # Use 2 nodes
#SBATCH --ntasks-per-node=2      # Run 2 tasks on the node
#SBATCH --cpus-per-task=2        # Allocate 2 CPUs per task
#SBATCH --time=00:10:00          # Set a 10-minute time limit
#SBATCH --output=output.txt

# Run the program
my_program_to_run 
Two nodes are used, each running two tasks. Each task gets 2 CPU cores, so each node uses 4 CPU cores in total.
Use Case: Running a distributed application, such as an MPI program or a parallelized computation across multiple nodes.

# Now we are going to simulate large sequence alignment and then estimate a tree in IQTREE.
# We will use our newick tree (((((t4:0.7693521935,t2:0.6895658914):0.1736953778,t8:0.05722095515):0.6099326028,t5:0.8962257898):0.2785755633,(t1:0.2424802384,(t9:0.1857078383,t7:0.9508992992):0.4160948298):0.03985421476):0.8241086977,((t6:0.82709398,t3:0.8704208957):0.8896566981,t10:0.2016652233):0.4047003295);

Below is the submission script:

#!/bin/bash
#SBATCH -J iqtree_run
#SBATCH --account=personal
#SBATCH --partition=normal_q
#SBATCH --nodes=1                
#SBATCH --ntasks-per-node=1      
#SBATCH --cpus-per-task=1        
#SBATCH --time=03:00:00          
#SBATCH --output=output.txt

# Run IQTREE
iqtree2 --alisim alignment_simulated -m JC -t tree.nwk --length 150000 --out-format fasta
iqtree2 -s alignment_simulated.fa 

# what these commands in submission script are going to generate.
That comands describes who is the Host and the size. Examples: owl1 (AVX512, FMA3, 755 GB RAM) Also the time, date and hour. 96 CPU cores detected, the Length of output sequences, example: 5000, the model, example: Model: JC, and Number of output datasets. Example: 1

# Remeber that you need to put instructions in the file and submit your script like so:
sbatch my_job_script.sh

# To monitor the progress of your job(s) you can use the squeue command:
squeue -u your_id

# The output of the squeue command describes the status of jobs. For example: in Name, describes the name of the job or script submitted.User is the username of the person who submitted the job, the status of job, you can keep informed about the status, for example if is running, pending, or completed. The time of the job, when the job started. In NODELIST(REASON) we can see the reason why the job is pending, example: priority / probably is because you need to solve some priority insues.

# To cancel your specific job:
scancel JOB_ID

# To cancel all jobs associated with your account:
scancel -u your_id
