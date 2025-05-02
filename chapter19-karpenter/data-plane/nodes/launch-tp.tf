resource "aws_launch_template" "karpenter_tp" {
 name = "karpenter-tp"
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
  tag_specifications {
    resource_type = "instance"
    tags = {
       Name = var.cluster_name
    }
  }
}



/*

panic: failed to get region from metadata server: EC2MetadataRequestError: failed to get EC2 instance identity document
caused by: EC2MetadataError: failed to make EC2Metadata request

*/