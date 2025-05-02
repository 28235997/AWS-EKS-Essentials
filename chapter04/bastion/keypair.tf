resource "tls_private_key" "private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "key-pair" {
  key_name   = var.sshkey
  public_key = tls_private_key.private-key.public_key_openssh
}

resource "local_file" "exam-key" {
  content  = tls_private_key.private-key.private_key_pem
  filename = "${var.sshkey}.pem"
}
