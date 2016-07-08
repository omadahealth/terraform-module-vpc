#
#  file: networking-dhcp_options.tf
#  description: contains resource declaration for DHCP Option set
#

resource "aws_vpc_dhcp_options" "default" {
    domain_name_servers = ["${cidrhost(aws_vpc.vpc.cidr_block, 2)}","8.8.4.4","208.67.222.222"]
    tags {
      Name = "default"
      Environment = "${var.environment}"
    }
}

resource "aws_vpc_dhcp_options_association" "default" {
    vpc_id = "${aws_vpc.vpc.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.default.id}"
}
