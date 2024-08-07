provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "shared" {
  backend = "remote"

  config = {
    organization = "Lab5_1"
    workspaces = {
      name = "hcup-be-shared"
    }
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*20*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "user_data" {
  template = file("${path.module}/setup-hashicups.yaml")
}


