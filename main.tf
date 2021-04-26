provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "./credentials"
  profile                 = "default"
}

resource "aws_instance" "ansible_slave_instance" {
  ami = "${var.image_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  #security_groups = ["${aws_security_group.sg.id}"]
  associate_public_ip_address = true
  #subnet_id = "${var.private_subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  user_data = "${file("./userdata.sh")}"


  provisioner "local-exec" {
    command = <<EOT
      sleep 150;
      >hosts.ini;
      echo "[slave1]" | tee -a hosts.ini;
      echo "${self.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.private_key}" | tee -a hosts.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
      ansible-playbook -u ${var.ansible_user} --private-key ${var.private_key} -i hosts.ini play.yml
    EOT
  }

}




resource "aws_security_group" "sg" {
  #name = "app_security_group"
  description = "Allow HTTP from Anywhere"
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #vpc_id = "${aws_vpc.default.id}"

}

output "sg_id" {
  value = "${aws_security_group.sg.id}"
}

