packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
packer {
  required_plugins {
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}
source "amazon-ebs" "amazon-2" {
  ami_name      = "custom-amazon-image-packer-1"
  instance_type = "t3.small"
  region        = "us-east-1"
  source_ami    = "ami-00ec84c1189958713"
  ssh_username = "root"
}
build {
  name = "custom-amazon-build"
  sources = [
    "source.amazon-ebs.amazon-2"
  ]
  
  post-processor "vagrant" {}
  post-processor "compress" {}
}
