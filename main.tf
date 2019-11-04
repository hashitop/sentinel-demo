terraform {
  backend "remote" {
    organization = "hashitop-org"
    workspaces {
      name = "sentinel-demo"
    }
  }
}

provider "aws" {
  # region                  = "us-west-2"
  # profile                 = "default"
  # shared_credentials_file = "~/.aws/credentials"
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  availability_zone = "ap-southeast-2b"
}
