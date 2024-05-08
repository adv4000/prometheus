#!/bin/bash
#--------------------------------------------------------------------
# Script to Install Prometheus Node_Exporter on Linux
# Tested on Ubuntu 22.04, 24.04, Amazon Linux 2023
# Developed by Denis Astahov in 2024
#--------------------------------------------------------------------
# https://github.com/prometheus/node_exporter/releases
NODE_EXPORTER_VERSION="1.7.0"

cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v$NODE_EXPORTER_VERSION/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz
tar xvfz node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz
cd node_exporter-$NODE_EXPORTER_VERSION.linux-amd64

mv node_exporter /usr/bin/
rm -rf /tmp/node_exporter*

useradd -rs /bin/false node_exporter
chown node_exporter:node_exporter /usr/bin/node_exporter


cat <<EOF> /etc/systemd/system/node_exporter.service
[Unit]
Description=Prometheus Node Exporter
After=network.target
 
[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
ExecStart=/usr/bin/node_exporter
 
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter
systemctl status node_exporter
node_exporter --version
