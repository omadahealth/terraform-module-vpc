#
#  file: networking-route_table.tf
#  description: contains resource declarations for VPC route tables
#

# resource dmz route table
resource "aws_route_table" "dmz" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "dmz"
        Environment = "${var.environment}"
    }
}

resource "aws_route_table_association" "dmzAtodmz" {
    subnet_id = "${aws_subnet.dmzA.id}"
    route_table_id = "${aws_route_table.dmz.id}"
}
resource "aws_route_table_association" "dmzBtodmz" {
    subnet_id = "${aws_subnet.dmzB.id}"
    route_table_id = "${aws_route_table.dmz.id}"
}
resource "aws_route_table_association" "dmzCtodmz" {
    subnet_id = "${aws_subnet.dmzC.id}"
    route_table_id = "${aws_route_table.dmz.id}"
}

# resource private route table
resource "aws_route_table" "privateA" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat_gwA.id}"
    }

    tags {
        Name = "privateA"
        Environment = "${var.environment}"
    }
}

resource "aws_route_table_association" "privateAtoprivate" {
    subnet_id = "${aws_subnet.privateA.id}"
    route_table_id = "${aws_route_table.privateA.id}"
}

# resource private route table
resource "aws_route_table" "privateB" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat_gwB.id}"
    }

    tags {
        Name = "privateB"
        Environment = "${var.environment}"
    }
}
resource "aws_route_table_association" "privateBtoprivate" {
    subnet_id = "${aws_subnet.privateB.id}"
    route_table_id = "${aws_route_table.privateB.id}"
}

# resource private route table
resource "aws_route_table" "privateC" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat_gwC.id}"
    }

    tags {
        Name = "privateC"
        Environment = "${var.environment}"
    }
}
resource "aws_route_table_association" "privateCtoprivate" {
    subnet_id = "${aws_subnet.privateC.id}"
    route_table_id = "${aws_route_table.privateC.id}"
}
