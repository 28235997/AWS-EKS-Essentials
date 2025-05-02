
output "subnets" {
  value = data.aws_availability_zones.available.names[1]
}