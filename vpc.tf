/**
   file: vpc.tf
   description: contains resource declarations for the vpc (only)
**/

# Variable: `cidr`, required argument
variable "cidr" {}

# Variable: `name`, required argument
variable "name" {}

# Variable: `environment`, required argument
variable "environment" {}

# resource aws_vpc
resource "aws_vpc" "vpc" {
    cidr_block = "${var.cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "dedicated"

    tags {
        Name = "${var.name}"
        Environment = "${var.environment}"
    }
}

# Output: `vpc_id`, Purpose: ID of VPC resource
output "vpc_id" {
    value = "${aws_vpc.vpc.id}"
}

# Output: `default_sg`, Purpose: default security group ID
output "default_sg" {
    value = "${aws_vpc.vpc.default_security_group_id}"
}
