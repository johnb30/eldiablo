#!/usr/bin/env bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' |
tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update

echo "Installing base packages..."
sudo apt-get install git <<-EOF
yes
EOF
sudo apt-get install g++ <<-EOF
yes
EOF
sudo apt-get install default-jre <<-EOF
yes
EOF
sudo apt-get install zip
sudo apt-get install unzip
sudo apt-get install libxml2-dev <<-EOF
yes
EOF
sudo apt-get install libxslt1-dev <<-EOF
yes
EOF
sudo apt-get install python-dev <<-EOF
yes
EOF
sudo apt-get install python-pip <<-EOF
yes
EOF

echo "Cloning Phoenix pipeline files..."
sudo git clone https://github.com/openeventdata/phoenix_pipeline.git
sudo git clone https://github.com/openeventdata/scraper.git
sudo git clone https://github.com/openeventdata/stanford_pipeline.git

echo "Installing Python dependencies..."
sudo pip install -r scraper/requirements.txt
sudo pip install -r phoenix_pipeline/requirements.txt
sudo pip install -r stanford_pipeline/requirements.txt

echo "Installing PETRARCH..."
sudo pip install git+https://github.com/openeventdata/petrarch.git
cd

echo "Downloading CoreNLP..."
sudo wget http://www-nlp.stanford.edu/software/stanford-corenlp-full-2013-06-20.zip
sudo unzip stanford-corenlp-full-2013-06-20.zip
mv stanford-corenlp-full-2013-06-20 /home/vagrant/stanford-corenlp

echo "Downloading NLTK data..."
sudo mkdir -p nltk_data/tokenizers
cd nltk_data/tokenizers
sudo wget http://www.nltk.org/nltk_data/packages/tokenizers/punkt.zip
sudo unzip punkt.zip
cd
sudo mv nltk_data /usr/lib/nltk_data

echo "Installing MongoDB..."
sudo apt-get install mongodb-10gen

echo "Setting up crontab..."
sudo crontab /vagrant/crontab.txt
