resource "aws_launch_template" "launch_template" {
 name = "self-managed-launch-template"
 #console
# image_id = "ami-02a075420d95cd9c1"
#my packer image
image_id = "ami-06f441b00834e8880"
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
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  network_interfaces {
   associate_public_ip_address = false
  } 

user_data = filebase64("${path.module}/user-data.sh")
  tag_specifications {
    resource_type = "instance"
     tags = {
        name = "test"
      }
  }
}