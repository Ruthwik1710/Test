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
  public_key = "-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAhFV85rOOf5Sl8Ai5/ayRsAUHnen5i+MQPW1kf+W+RlpwJ6me
AdOqSVMIW/LMV/ODYgGprURdxdJU5OGzUGLisYBjz5hj0F1EHClb9TTohIul7uct
4WWKk2jfErUSUq20eiQIzqrjPmu5qWQBFGLz/aLc7EArZHzjkAIzabGnbhB1nx9g
y0VeAOJkPtlVpJ9o2kCM95wzrXzJ7nsGtw4hV5GPV+oEm3MBsBB6tj3O/rEM7foq
9xvPGNN51Gu64VBYTFVHS4p+rnCXe73pYI9U3biGi52XK2IILo9O+D6tv08XB9wM
rgLtvzaVO1MeF3LUtGbqhKIrrUwIRgPlk7kl1wIDAQABAoIBAEHUrS+u/yJkdi/0
h2G0aT0hI2rhLCz0pe2I78fYKFGjR8vTSzEpdLrJPY1QOWs/ToqAvUHekq+INIcv
6B4DMzaN4hkxe+X5n5pK0N4olcrqFX/FLUPFWax/LQmHXjgXBYMFTgRRan5w5Ilp
oEfd+fahADneqjdxEVtgXOclY18Sv98VnVo1Z80MS1frHU3Y4zgEZ+12zO7uFtXc
WthKC3CNhIuVRKxCx652ZZPS9UJJTA4w2fQjEEG6FMUKVZXSp0Og5oRsr8214csM
DySJBW7kXcqNR8oldiME381Jsq7fUms20wADwRjri8+O+Ps2TSY4lTtA6i6XcAdC
zZvj1hECgYEA7e1JM6PxvdtGbCRSKd3e7mbWw+pD/Er3TuFgkMh0FrdLN3QWseXJ
/g+BSvbqlowJ4xIc7Ipa3ZX/gJZbQaoSogJxA5pGYojlUVcIAC3a3IvF95yiVhju
i5Jwmhg4q5vNRjpf4V8Ff+BTgXI6A5A5zpyi2DwAVUWf6/ZBc9lKQWsCgYEAjmLY
w6LWSZRvgah+XenZnOpMt3bLhB6TUXdFxK9yW7Q6ThTnWCmskFiRquKT3h8Fl6NC
BNQU6Z8D2le/kwxttl1tRRRqSTMtlaHwnPKhCzCXs7zgITZHcu6bqUiqt8323gWO
ZoYbZoP/67rxLautvLuVDmfuIntSWqs7aN2NjEUCgYEAkcpalpgY4ztf1ZgT+K+J
kQ/W/cmoywmsrNsRbuZFrD24i0xJM80YjuM1WJggewtoa4mHy7GjqC/nlgWL+Zqb
PEa+tXRtOKelzMfFkUaH26iSL/38w0EXutKKyQGaiB06FZRjeBffqNHumV1DCzfv
FBmK93EcyyOUsOP+i1xUUe0CgYB9xst8ZcetT7YAbvrRstVMS5xhJEs69ldkS1wS
FnmKkHZAqy6BLq8FA3gJ4ASG3hhujwSuhznB9XnN0l2kZAI2aekwcIxDBTZrS5Xk
zl98JvybBWlnbS9IU4alz08e9o3wKjBUWHqz4D6d2ZFaqqDaa0mMZDpzs0RYW5Ir
XCrBkQKBgAJKYNyKsGr08FtCZ5sATjBNQB05+VcgaWP9Gy6cePuOs6erD8JVhpj/
EKr2vFctNH8TKeU4U8J65oJifh9tLJYcfHid2Wd+mMwSgrIO6lUh+DWx6mO+JQIy
TJGIOFSKBtW3FmuhDuUiDFHHUoSG2V9+i/MdQDhJVzvpNOZ9CeZK
-----END RSA PRIVATE KEY-----"
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id
tags= {
    Name = "my_elastic_ip"
  }
}
