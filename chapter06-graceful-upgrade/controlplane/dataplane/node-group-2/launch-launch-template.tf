resource "aws_launch_template" "launch_template_node_group_2" {
 name = "launch-template-node-group-2"

#k8s version 1.31 image for drain node
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