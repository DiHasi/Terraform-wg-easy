# Install Docker
Set up Docker's apt repository.
```
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
```

Install last version
```
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

# Install [Terraform](https://developer.hashicorp.com/terraform) 

Ensure that your system is up to date and that you have installed the gnupg and *software-properties-common packages*. You will use these packages to verify HashiCorp's GPG signature and install HashiCorp's Debian package repository.
``` bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```
Install HashiCorp's GPG key.
``` bash
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```

Add the official HashiCorp repository to your system.
``` bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```
Update apt to download the package information from the HashiCorp repository.
``` bash
sudo apt update
```
Install Terraform from the new repository.
```
sudo apt-get install terraform
```
Then install the autocomplete package.
```
terraform -install-autocomplete
```


# Clone repository
```
git clone https://github.com/DiHasi/Terraform-wg-easy.git
cd Terraform-wg-easy
```

# Terraform 
```
terraform init
terraform plan
terraform apply
```
