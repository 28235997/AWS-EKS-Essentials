resource "aws_launch_template" "launch_template_node_group" {
 name = "launch-template-node-group"
 block_device_mappings {
    device_name = "/dev/sdf"
    ebs {
      volume_size = 50
    }
  }
  ebs_optimized = true
  metadata_options {
    http_tokens    = "optional"
    http_put_response_hop_limit = 2
  }
  network_interfaces {
   associate_public_ip_address = false
  } 
}

