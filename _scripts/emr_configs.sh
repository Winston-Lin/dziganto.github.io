# AWS EMR 5.4.0 bootstrap script for installing/configuring Anaconda, additional
# Python packages, Tensorflow w/Keras, and Theano

# ----------------------------------------------------------------------
#  move /usr/lib to /mnt/usr-moved/lib; otherwise run out of space on /
# ----------------------------------------------------------------------
sudo mkdir /mnt/usr-moved
sudo mv /usr/local /mnt/usr-moved/
sudo ln -s /mnt/usr-moved/local /usr/
sudo mv /usr/share /mnt/usr-moved/
sudo ln -s /mnt/usr-moved/share /usr/

# ----------------------------------------------------------------------
#              Install Anaconda (Python 3) & Set To Default              
# ----------------------------------------------------------------------
wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh -O ~/anaconda.sh
bash ~/anaconda.sh -b -p $HOME/anaconda
echo -e '\nexport PATH=$HOME/anaconda/bin:$PATH' >> $HOME/.bashrc && source $HOME/.bashrc
conda create -n py35 python=3.5 -y
echo -e '\nsource activate py35' >> $HOME/.bashrc && source $HOME/.bashrc

# ----------------------------------------------------------------------
#                    Install Additional Packages              
# ----------------------------------------------------------------------
conda install -y psycopg2 gensim
pip install textblob selenium 

# ----------------------------------------------------------------------
#         Install Tensorflow (CPU only and installs Keras )              
# ----------------------------------------------------------------------
conda create -yn tensorflow
source activate tensorflow
pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.1-cp36-cp36m-linux_x86_64.whl
source deactivate

# ----------------------------------------------------------------------
#                         Install Theano            
# ----------------------------------------------------------------------
conda install -y theano pygpu

# ----------------------------------------------------------------------
#                         Security Update            
# ----------------------------------------------------------------------
sudo yum -y update
