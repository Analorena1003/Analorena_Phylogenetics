Installing Miniconda (mamba) so that you can install tools more easily
Download the installer into your home folder. Go to https://github.com/conda-forge/miniforge to find the appropriate version. For the VT ARC this will be the Linux AMD64 version. Right click on the download link and choose “copy link”

wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh

Type ls and locate the Miniconda file you just downloaded. It should end with “.sh”

ls ls *.sh

Now run the script with the "bash" command and follow the instructions when prompted

bash Miniforge3-Linux-x86_64.sh

It may ask you for a folder where it will put all the relevant code. The default option should be fine. At the end it will ask you if it wants you to alter your PATH to add Miniconda. The default is “no”, but you should answer “yes”. If you answer “no” on accident, re-run the “bash <the Miniconda file.sh” command above, and add the “-u “ flag after the bash command.

Now, once mini-force is installed, we need to create a file called .bash_profile so that conda-forge will activate when start a new terminal. This should happen automatically, but because of a strange quirk on the ARC system, it does not. To do this, copy the following command into your terminal and then hit enter:

cp .bashrc .bash_profile

After this is done, open a new terminal and type “mamba” to see if the help menu comes up. If you see a help menu, it has been installed properly! Once mamba is installed, create an environment that you can use for this class with

mamba create -n py39 python=3.9

Now, when you start a session, you can activate this environment by running:

mamba activate SYSB3035
