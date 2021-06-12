#!/bin/bash
# A simple script

sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y

sudo apt install nano -y
sudo apt install python -y
sudo apt install w3m -y
sudo apt install w3m-img -y
sudo apt install openjdk-8-jdk -y
sudo apt install gnupg2 -y
sudo apt install nginx -y
sudo apt install apt-transport-https -y
sudo apt install curl -y

curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y

sudo apt install elasticsearch -y
sudo apt install kibana -y
sudo apt install logstash -y
sudo apt install filebeat -y 
sudo apt install metricbeat -y

pushd /etc/elasticsearch
curl -O https://raw.githubusercontent.com/d-x-b/ubuntu_elk/main/Ubuntu/elasticsearch.yml
popd

pushd /etc/kibana
curl -O https://raw.githubusercontent.com/d-x-b/ubuntu_elk/main/Ubuntu/kibana.yml
popd

pushd /etc/logstash
curl -O https://raw.githubusercontent.com/d-x-b/ubuntu_elk/main/Ubuntu/logstash.yml
popd

pushd /etc/filebeat
curl -O https://raw.githubusercontent.com/d-x-b/ubuntu_elk/main/Ubuntu/filebeat.yml
popd

pushd /etc/metricbeat
curl -O https://raw.githubusercontent.com/d-x-b/ubuntu_elk/main/Ubuntu/metricbeat.yml
popd

sudo systemctl start elasticsearch.service
sudo systemctl enable elasticsearch.service
sudo ufw allow 9200
curl -X GET "192.168.69.89:9200"

sudo systemctl start kibana
sudo systemctl enable kibana
sudo ufw allow 5601

sudo systemctl start logstash
sudo systemctl enable logstash

sudo filebeat modules enable kibana elasticsearch logstash system auditd
sudo filebeat setup
sudo systemctl start filebeat
sudo systemctl enable filebeat

sudo metricbeat modules enable kibana elasticsearch logstash system
sudo metricbeat setup
sudo systemctl start metricbeat
sudo systemctl enable metricbeat
