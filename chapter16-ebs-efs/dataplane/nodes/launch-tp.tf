resource "aws_launch_template" "on_spot_tp" {
 name = "on-spot-tp"
 instance_type = var.instance_type
 block_device_mappings {
    device_name = "/dev/sdf"
    ebs {
      volume_size = 100
    }
  }
  ebs_optimized = true
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    instance_metadata_tags      = "enabled"
  }
  network_interfaces {
   associate_public_ip_address = false
  } 
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "on-spot-node-group"
    }
  }
}