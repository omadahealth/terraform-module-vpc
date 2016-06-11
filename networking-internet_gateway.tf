/**
  file: networking-internet_gateway.tf
  description: contains resource declarations for VPC internet gateway
**/

## --- Internet (Provider)

# resource igw
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_eip" "nat_gw_eipA" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gwA" {
  allocation_id = "${aws_eip.nat_gw_eipA.id}"
  subnet_id = "${aws_subnet.dmzA.id}"
}


resource "aws_eip" "nat_gw_eipB" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gwB" {
  allocation_id = "${aws_eip.nat_gw_eipB.id}"
  subnet_id = "${aws_subnet.dmzB.id}"
}

resource "aws_eip" "nat_gw_eipC" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gwC" {
  allocation_id = "${aws_eip.nat_gw_eipC.id}"
  subnet_id = "${aws_subnet.dmzC.id}"
}


output "Nat_A_EIP" {
    value = "${aws_eip.nat_gw_eipA.public_ip}"
}

output "Nat_B_EIP" {
    value = "${aws_eip.nat_gw_eipB.public_ip}"
}

output "Nat_C_EIP" {
    value = "${aws_eip.nat_gw_eipC.public_ip}"
}
