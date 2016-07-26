#
#  file: networking-route_table.tf
#  description: contains resource declarations for VPC route tables
#

# resource dmz route table
resource "aws_route_table" "dmz" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name = "dmz"
        Environment = "${var.environment}"
    }
}

resource "aws_route" "dmz_to_igw" {
    route_table_id = "${aws_route_table.dmz.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
}

output "dmz_route_table" {
    value = "${aws_route_table.dmz.id}"
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

    tags {
        Name = "privateA"
        Environment = "${var.environment}"
    }
}

resource "aws_route" "privateA_to_ngwA" {
    route_table_id = "${aws_route_table.privateA.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gwA.id}"
}

resource "aws_route_table_association" "privateAtoprivate" {
    subnet_id = "${aws_subnet.privateA.id}"
    route_table_id = "${aws_route_table.privateA.id}"
}

# resource private route table
resource "aws_route_table" "privateB" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name = "privateB"
        Environment = "${var.environment}"
    }
}

resource "aws_route" "privateB_to_ngwB" {
    route_table_id = "${aws_route_table.privateB.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gwB.id}"
}

resource "aws_route_table_association" "privateBtoprivate" {
    subnet_id = "${aws_subnet.privateB.id}"
    route_table_id = "${aws_route_table.privateB.id}"
}

# resource private route table
resource "aws_route_table" "privateC" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name = "privateC"
        Environment = "${var.environment}"
    }
}

resource "aws_route" "privateC_to_ngwC" {
    route_table_id = "${aws_route_table.privateC.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gwC.id}"
}

resource "aws_route_table_association" "privateCtoprivate" {
    subnet_id = "${aws_subnet.privateC.id}"
    route_table_id = "${aws_route_table.privateC.id}"
}

output "private_route_tables" {
    value = "${aws_route_table.privateA.id},${aws_route_table.privateB.id},${aws_route_table.privateC.id}"
}
