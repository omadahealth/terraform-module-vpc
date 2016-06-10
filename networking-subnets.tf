/**
  file: networking-subnets.tf
  description: contains networking resources
**/

## --- DMZ

# resource subnet dmzA
resource "aws_subnet" "dmzA" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 1)}"
    map_public_ip_on_launch = true
}

# resource subnet dmzB
resource "aws_subnet" "dmzB" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 2)}"
    map_public_ip_on_launch = true
}

# resource subnet dmzC
resource "aws_subnet" "dmzC" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 3)}"
    map_public_ip_on_launch = true
}

output "dmz_subnet_ids" {
  value = "${aws_subnet.dmzA.id},${aws_subnet.dmzB.id},${aws_subnet.dmzC.id}"
}

output "dmz_subnet_cidrs" {
  value = "${aws_subnet.dmzA.cidr_block},${aws_subnet.dmzB.cidr_block},${aws_subnet.dmzC.cidr_block}"
}

## --- Private

# resource subnet privateA
resource "aws_subnet" "privateA" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 4)}"
}

# resource subnet privateB
resource "aws_subnet" "privateB" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 5)}"
}

# resource subnet privateC
resource "aws_subnet" "privateC" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 6)}"
}

output "private_subnet_ids" {
  value = "${aws_subnet.privateA.id},${aws_subnet.privateB.id},${aws_subnet.privateC.id}"
}

output "private_subnet_cidrs" {
  value = "${aws_subnet.privateA.cidr_block},${aws_subnet.privateB.cidr_block},${aws_subnet.privateC.cidr_block}"
}

