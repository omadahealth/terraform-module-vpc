module "vpc" {
    source = "../"
    cidr = "10.0.0.0/16"
    name = "test"
    environment = "vpc_test"
}

variable "ssh_public_key_path" {
    default = "~/.ssh/id_rsa.pub"
}

resource "aws_key_pair" "local" {
    key_name = "vpc-module-testing-key"
    public_key = "${file(var.ssh_public_key_path)}"
}

output "fingerprint" {
    value = "${aws_key_pair.local.fingerprint}"
}

resource "aws_security_group" "ssh" {
    name = "ssh"
    description = "figure it out"
    vpc_id = "${module.vpc.vpc_id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "test_dmz" {
    ami = "ami-98e114f8"
    instance_type = "m3.medium"
    key_name = "vpc-module-testing-key"

    subnet_id = "${element(split(",", module.vpc.dmz_subnet_ids), 0)}"
    vpc_security_group_ids = ["${module.vpc.default_sg}", "${aws_security_group.ssh.id}"]
}


resource "aws_instance" "test_private" {
    ami = "ami-98e114f8"
    instance_type = "m3.medium"
    key_name = "vpc-module-testing-key"

    subnet_id = "${element(split(",", module.vpc.private_subnet_ids), 0)}"
    vpc_security_group_ids = ["${module.vpc.default_sg}", "${aws_security_group.ssh.id}"]
}
