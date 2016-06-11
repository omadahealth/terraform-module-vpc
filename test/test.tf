module "vpc" {
    source = "../"
    region = "${var.region}"
    cidr = "10.0.0.0/16"
    name = "test"
    environment = "vpc_test"
}

variable "ssh_public_key_path" {
    default = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
    default = "~/.ssh/id_rsa"
}

resource "aws_key_pair" "local" {
    key_name = "vpc-module-testing-key"
    public_key = "${file(var.ssh_public_key_path)}"
}

output "fingerprint" {
    value = "${aws_key_pair.local.fingerprint}"
}

output "Nat_A_EIP" {
    value = "${module.vpc.Nat_A_EIP}"
}

output "Nat_B_EIP" {
    value = "${module.vpc.Nat_B_EIP}"
}

output "Nat_C_EIP" {
    value = "${module.vpc.Nat_C_EIP}"
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

resource "aws_instance" "test_dmz0" {
    ami = "ami-98e114f8"
    instance_type = "m3.medium"
    key_name = "vpc-module-testing-key"

    subnet_id = "${element(split(",", module.vpc.dmz_subnet_ids), 0)}"
    vpc_security_group_ids = ["${module.vpc.default_sg}", "${aws_security_group.ssh.id}"]

    # Can we ping out to the internet?
    provisioner "remote-exec" {
        inline = ["echo 'ping -c 1 google.com'", "ping -c 1 google.com"]

        connection {
            type = "ssh"
            user = "admin"
            private_key = "${file(var.ssh_private_key_path)}"
        }
    }

    # Can we ping to other dmz hosts?
    provisioner "remote-exec" {
        inline = ["echo 'ping -c 1 ${aws_instance.test_dmz1.private_ip}'", "ping -c 1 ${aws_instance.test_dmz1.private_ip}"]

        connection {
            type = "ssh"
            user = "admin"
            private_key = "${file(var.ssh_private_key_path)}"
        }
    }
    provisioner "remote-exec" {
        inline = ["echo 'ping -c 1 ${aws_instance.test_dmz2.private_ip}'", "ping -c 1 ${aws_instance.test_dmz2.private_ip}"]

        connection {
            type = "ssh"
            user = "admin"
            private_key = "${file(var.ssh_private_key_path)}"
        }
    }
}


resource "aws_instance" "test_dmz1" {
    ami = "ami-98e114f8"
    instance_type = "m3.medium"
    key_name = "vpc-module-testing-key"

    subnet_id = "${element(split(",", module.vpc.dmz_subnet_ids), 1)}"
    vpc_security_group_ids = ["${module.vpc.default_sg}", "${aws_security_group.ssh.id}"]

    # Can we ping out to the internet?
    provisioner "remote-exec" {
        inline = ["echo 'ping -c 1 google.com'", "ping -c 1 google.com"]

        connection {
            type = "ssh"
            user = "admin"
            private_key = "${file(var.ssh_private_key_path)}"
        }
    }
}

resource "aws_instance" "test_dmz2" {
    ami = "ami-98e114f8"
    instance_type = "m3.medium"
    key_name = "vpc-module-testing-key"

    subnet_id = "${element(split(",", module.vpc.dmz_subnet_ids), 2)}"
    vpc_security_group_ids = ["${module.vpc.default_sg}", "${aws_security_group.ssh.id}"]

    # Can we ping out to the internet?
    provisioner "remote-exec" {
        inline = ["echo 'ping -c 1 google.com'", "ping -c 1 google.com"]

        connection {
            type = "ssh"
            user = "admin"
            private_key = "${file(var.ssh_private_key_path)}"
        }
    }
}


resource "aws_instance" "test_private0" {
    ami = "ami-98e114f8"
    instance_type = "m3.medium"
    key_name = "vpc-module-testing-key"

    subnet_id = "${element(split(",", module.vpc.private_subnet_ids), 0)}"
    vpc_security_group_ids = ["${module.vpc.default_sg}", "${aws_security_group.ssh.id}"]

    # Can we ping out to the internet?
    provisioner "remote-exec" {
        inline = ["echo 'ping -c 1 google.com'", "ping -c 1 google.com"]

        connection {
            type = "ssh"
            user = "admin"
            private_key = "${file(var.ssh_private_key_path)}"
            bastion_host = "${aws_instance.test_dmz0.public_ip}"
        }
    }


    # Can we ping other private hosts?
    provisioner "remote-exec" {
        inline = ["echo 'ping -c 1 ${aws_instance.test_private1.private_ip}'", "ping -c 1 ${aws_instance.test_private1.private_ip}"]

        connection {
            type = "ssh"
            user = "admin"
            private_key = "${file(var.ssh_private_key_path)}"
            bastion_host = "${aws_instance.test_dmz0.public_ip}"
        }
    }
    provisioner "remote-exec" {
        inline = ["echo 'ping -c 1 ${aws_instance.test_private2.private_ip}'", "ping -c 1 ${aws_instance.test_private2.private_ip}"]

        connection {
            type = "ssh"
            user = "admin"
            private_key = "${file(var.ssh_private_key_path)}"
            bastion_host = "${aws_instance.test_dmz0.public_ip}"
        }
    }
}


resource "aws_instance" "test_private1" {
    ami = "ami-98e114f8"
    instance_type = "m3.medium"
    key_name = "vpc-module-testing-key"

    subnet_id = "${element(split(",", module.vpc.private_subnet_ids), 1)}"
    vpc_security_group_ids = ["${module.vpc.default_sg}", "${aws_security_group.ssh.id}"]

    # Can we ping out to the internet?
    provisioner "remote-exec" {
        inline = ["echo 'ping -c 1 google.com'", "ping -c 1 google.com"]

        connection {
            type = "ssh"
            user = "admin"
            private_key = "${file(var.ssh_private_key_path)}"
            bastion_host = "${aws_instance.test_dmz1.public_ip}"
        }
    }
}


resource "aws_instance" "test_private2" {
    ami = "ami-98e114f8"
    instance_type = "m3.medium"
    key_name = "vpc-module-testing-key"

    subnet_id = "${element(split(",", module.vpc.private_subnet_ids), 2)}"
    vpc_security_group_ids = ["${module.vpc.default_sg}", "${aws_security_group.ssh.id}"]

    # Can we ping out to the internet?
    provisioner "remote-exec" {
        inline = ["echo 'ping -c 1 google.com'", "ping -c 1 google.com"]

        connection {
            type = "ssh"
            user = "admin"
            private_key = "${file(var.ssh_private_key_path)}"
            bastion_host = "${aws_instance.test_dmz2.public_ip}"
        }
    }

}