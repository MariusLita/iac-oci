#!/bin/bash

exec > /var/tmp/user_data.log 2>&1
echo "Starting user_data script"

# Increase the timeout for yum/dnf
echo "Setting yum timeout"
echo "timeout=2000" >> /etc/dnf/dnf.conf
echo "timeout=2000" >> /etc/yum.conf

# Update system and install required packages
# sudo yum update -y
dnf install -y wget unzip httpd dnf-plugins-core

# Install Kubernetes kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Docker
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable --now docker
usermod -aG docker opc

# Configure and start HTTP server
systemctl enable --now httpd

# Allow HTTP service in firewall
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --reload

# Download and deploy HTML template
wget https://www.tooplate.com/zip-templates/2137_barista_cafe.zip
unzip -o 2137_barista_cafe.zip
cp -r 2137_barista_cafe/* /var/www/html/

# Restart HTTP server to apply changes
systemctl restart httpd

echo "Script completed"