provider "aws" {
  region = var.aws_region
}

#Create security group with firewall rules
resource "aws_security_group" "my_security_group" {
  name        = var.security_group
  description = "security group for Ec2 instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

# Create AWS ec2 instance
resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  key_name = "Task"
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = var.tag_name
  }
}
#key pair
resource "aws_key_pair" "Task"{
  key_name = "Task"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCEVXzms45/lKXwCLn9rJGwBQed6fmL4xA9bWR/5b5GWnAnqZ4B06pJUwhb8sxX84NiAamtRF3F0lTk4bNQYuKxgGPPmGPQXUQcKVv1NOiEi6Xu5y3hZYqTaN8StRJSrbR6JAjOquM+a7mpZAEUYvP9otzsQCtkfOOQAjNpsaduEHWfH2DLRV4A4mQ+2VWkn2jaQIz3nDOtfMnuewa3DiFXkY9X6gSbcwGwEHq2Pc7+sQzt+ir3G88Y03nUa7rhUFhMVUdLin6ucJd7velgj1TduIaLnZcrYgguj074Pq2/TxcH3AyuAu2/NpU7Ux4XctS0ZuqEoiutTAhGA+WTuSXX imported-openssh-key"
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id
tags= {
    Name = "my_elastic_ip"
  }
}
