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

source "amazon-ebs" "ubuntu" {
  ami_name      = "my-eks-ubuntu"
  instance_type = "t3.small"
  region        = "us-east-1"
  source_ami    = "ami-021d881906d349911"
  ssh_username = "ubuntu"
}

build {
  name = "my-first-build"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  
  provisioner "shell" {
    inline = [
      "sudo apt update"
    ]
  }
  

  post-processor "vagrant" {}
  post-processor "compress" {}
}
