Prerequistes:
1. The system where we run this terraform code should have Terrafom, Ansible and awcli installed and configured.

	Commands for installing in Linux:
	Note: below approach will work only with Linux server

	- Terraform:
		curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
		sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
		sudo apt-get update && sudo apt-get install terraform

	- PIP install
		curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
		python get-pip.py --user

	- Ansible:
		python -m pip install --user ansible

	- WGET:
		sudo yum install -y wget

	- AWSCLI:
		curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
		unzip awscliv2.zip
		sudo ./aws/install


2. A profile should be created while configuring awscli in us-east-1 region, profile name and path of the credentials should be updated in main.tf(line 4, 5)
	aws 
		
	- AWC CLI configured command and steps.
		aws configure --profile default
		Enter the below details:
		AWS Access Key ID [None]: ******
		AWS Secret Access Key [None]: *****
		Default region name [None]: us-east-1
		Default output format [None]: json

3. A key pair should be created and its name should be updated in variables.tf(line 21)

4. Please follow the below steps to pull the repository to local machine
	- pull the master repo in your local host using "git pull origin master"
    - Initialize the terraform script using "terraform init" - it will download necessary plugins and modules
    - plan the infrastructure using "terraform plan"
    - Create the infrastructure using "terraform apply"
    - In case, if you would like to delete the created infracture , execute "terraform destroy"