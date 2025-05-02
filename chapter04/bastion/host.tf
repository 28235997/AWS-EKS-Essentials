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
  tags = {
    "Name" : "bastion-host"
  }
}