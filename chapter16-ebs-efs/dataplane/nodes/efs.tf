resource "aws_efs_file_system" "efs-storage" {
   creation_token = "efs-storage"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
 tags = {
     Name = "EfsStorage"
   }
 }
#mount point
 resource "aws_efs_mount_target" "efs-mt-storage" {
   file_system_id  = aws_efs_file_system.efs-storage.id
   security_groups = [var.security_group_id]
   subnet_id = var.subnets_id[0]
 }

