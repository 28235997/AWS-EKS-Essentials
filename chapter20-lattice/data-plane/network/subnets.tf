
data "aws_availability_zones" "azs" {
 state = "available"
}

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block  = count.index == 0 ? var.cidr_blocks["private-subnet-1"] : var.cidr_blocks["private-subnet-2"]
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  count = 2
  tags = {
    Name = "private-subnet-${count.index+1}"
    
     "kubernetes.io/role/internal-elb"               = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    
  }
  
}

resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block  = count.index == 0 ? var.cidr_blocks["public-subnet-1"] : var.cidr_blocks["public-subnet-2"]
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  count = 2
  tags = {
    Name = "public-subnet-${count.index+1}"
      "kubernetes.io/role/elb"                        = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}