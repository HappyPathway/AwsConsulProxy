sudo apt-get update
sudo apt-get install -y python-pip
sudo pip install -r /tmp/playbooks/requirements.txt
sudo ansible-playbook /tmp/playbooks/proxy_install.yaml -e env=$(cat /tmp/app.env) -e service_name=$(cat /tmp/app.service)
sudo rm -rf /tmp/playbooks