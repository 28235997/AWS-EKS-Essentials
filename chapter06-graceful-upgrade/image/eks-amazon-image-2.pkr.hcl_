
//enable internet gateway and attach it to the default vpc, if it doesnt exist
//configure route to allow internet access
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

source "amazon-ebs" "ubuntu-2" {
  ami_name      = "my-eks-ubuntu-2"
  instance_type = "t3.small"
  region        = "us-east-1"
  source_ami    = "ami-01245cd11f66cbe6c"
  ssh_username = "ubuntu"
}

build {
  name = "my-second-build"
  sources = [
    "source.amazon-ebs.ubuntu-2"
  ]
  
  post-processor "vagrant" {}
  post-processor "compress" {}
}

