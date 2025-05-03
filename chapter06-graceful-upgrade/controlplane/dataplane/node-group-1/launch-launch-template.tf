resource "aws_launch_template" "launch_template_node_group_1" {
 name = "launch-template-node-group-1"

 #version 1.30 image for tainted nodes
 image_id = "ami-02a075420d95cd9c1"
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