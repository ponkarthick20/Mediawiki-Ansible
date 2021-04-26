#Update the region where we are creating the resource 
variable "region" {
  default = "us-east-1"
}
variable "availability_zones" {
  # No spaces allowed between az names!
  default = "us-east-1a,us-east-1b,us-east-1c"
}
variable "instance_type" {
  default = "t2.micro"
}
#Update the keypair name using for EC2 creation
variable "key_name" {
  default = "karthi"
}
variable "image_id" {
  default =  "ami-0001378efdafd5401"
}

#update the pem path here
variable "private_key" {
  default = "/home/centos/ansi/karthi.pem"
}

variable "ansible_user" {
  default = "centos"
}
variable "host_ip" {
  default = "self.public_ip"
}

