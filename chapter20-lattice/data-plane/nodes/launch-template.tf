resource "aws_launch_template" "launch_template" {
 name = "ip-prefix-launch-template"
 block_device_mappings {
    device_name = "/dev/sdf"
    ebs {
      volume_size = 50
    }
  }
  ebs_optimized = true
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "enabled"
  }
  network_interfaces {
   associate_public_ip_address = false
  } 
#user data encoding
user_data = filebase64("${path.module}/user-data.sh")
  tag_specifications {
    resource_type = "instance"
     tags = {
        name = "ip-prefix-custom-launch-template"
      }
  }
}