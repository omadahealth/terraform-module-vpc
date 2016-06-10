/**
  file: networking-internet_gateway.tf
  description: contains resource declarations for VPC internet gateway
**/

## --- Internet (Provider)

# resource igw
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.vpc.id}"
}
