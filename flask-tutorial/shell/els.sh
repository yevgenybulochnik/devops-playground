cd /home/vagrant/
apt-add-repository ppa:webupd8team/java -y
apt update -y
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt install oracle-java8-installer -y

sysctl -w vm.max_map_count=262144

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.5.4.tar.gz
su - vagrant -c 'tar -xzvf elasticsearch-6.5.4.tar.gz'
echo network.host: els >> ./elasticsearch-6.5.4/config/elasticsearch.yml
su - vagrant -c './elasticsearch-6.5.4/bin/elasticsearch -d -p pid'
