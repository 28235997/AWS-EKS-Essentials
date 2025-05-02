resource "aws_instance" "instances" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  key_name      = var.sshkey
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  subnet_id                   =  var.subnet_id
  vpc_security_group_ids      = [aws_security_group.sg.id] 
  associate_public_ip_address = true

  user_data = <<-EOL
     #!/bin/bash -xe
     sudo apt update 
     sudo apt -y install nfs-kernel-server
     sudo systemctl enable nfs-kernel-server.service
     sudo systemctl start nfs-kernel-server.service
     sudo apt -y install nfs-common
     sudo mkdir -p /mnt/nfs_share
     sudo chown -R nobody:nogroup /mnt/nfs_share/
     sudo chmod 777 /mnt/nfs_share/
     sudo echo '/mnt/nfs_share 10.0.0.0/16(rw,sync,no_subtree_check)' >> /etc/exports
     sudo exportfs -rav
     sudo systemctl restart nfs-kernel-server.service
  EOL

  tags = {
    "Name" : var.instance-tags
  }
}