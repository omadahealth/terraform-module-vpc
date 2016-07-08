#
#  file: networking-subnets.tf
#  description: contains networking resources
#

## --- DMZ

# resource subnet dmzA
resource "aws_subnet" "dmzA" {
    availability_zone = "${var.region}a"
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 1)}"
    map_public_ip_on_launch = true

    tags {
        Name = "dmzA"
        Environment = "${var.environment}"
    }
}

# resource subnet dmzB
resource "aws_subnet" "dmzB" {
    availability_zone = "${var.region}b"
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 2)}"
    map_public_ip_on_launch = true

    tags {
        Name = "dmzB"
        Environment = "${var.environment}"
    }
}

# resource subnet dmzC
resource "aws_subnet" "dmzC" {
    availability_zone = "${var.region}c"
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 3)}"
    map_public_ip_on_launch = true

    tags {
        Name = "dmzC"
        Environment = "${var.environment}"
    }
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
    availability_zone = "${var.region}a"
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 4)}"

    tags {
        Name = "privateA"
        Environment = "${var.environment}"
    }
}

# resource subnet privateB
resource "aws_subnet" "privateB" {
    availability_zone = "${var.region}b"
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 5)}"

    tags {
        Name = "privateB"
        Environment = "${var.environment}"
    }
}

# resource subnet privateC
resource "aws_subnet" "privateC" {
    availability_zone = "${var.region}c"
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(var.cidr, 5, 6)}"

    tags {
        Name = "privateC"
        Environment = "${var.environment}"
    }
}

output "private_subnet_ids" {
  value = "${aws_subnet.privateA.id},${aws_subnet.privateB.id},${aws_subnet.privateC.id}"
}

output "private_subnet_cidrs" {
  value = "${aws_subnet.privateA.cidr_block},${aws_subnet.privateB.cidr_block},${aws_subnet.privateC.cidr_block}"
}

