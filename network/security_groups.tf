# Create security group. 

# Incoming and outgoing rules defining allowed IP ranges, ports and protocols are 
# attached to the security groups.

# The security groups in turn are attached to instances. Then the instances start getting 
# traffic subject to the rules attached to the given security groups. 

resource "aws_security_group" "BastionSG" {
  name        = "BastionSG"
  description = "allow_ssh"
  vpc_id      = aws_vpc.main.id
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "BastionSG"
  }
}

# Create incoming and outgoing rules for the created security group
resource "aws_vpc_security_group_ingress_rule" "allow_incoming_ssh_ipv4" {
  security_group_id = aws_security_group.BastionSG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  tags = {
    "Name" = "bastion_incoming_ssh_ipv4"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outgoing_traffic_ipv4" {
  security_group_id = aws_security_group.BastionSG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  tags = {
    "Name" = "bastion_outgoing_ipv4"
  }
}

##### Bastion hosts access to Private app instances #################################
resource "aws_security_group" "AppSG" {
  name        = "AppSG"
  description = "Allow ssh"
  vpc_id      = aws_vpc.main.id
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "AppSG"
  }
}

# Create incoming and outgoing rules for the created security group
resource "aws_vpc_security_group_ingress_rule" "ssh_from_bastionA" {
  security_group_id = aws_security_group.AppSG.id
  cidr_ipv4   = "172.16.1.0/24"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  tags = {
    "Name" = "ssh_from_bastionA"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_from_bastionB" {
  security_group_id = aws_security_group.AppSG.id
  cidr_ipv4   = "172.16.2.0/24"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  tags = {
    "Name" = "ssh_from_bastionB"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_from_bastionC" {
  security_group_id = aws_security_group.AppSG.id
  cidr_ipv4   = "172.16.3.0/24"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  tags = {
    "Name" = "ssh_from_bastionC"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outgoing_traffic_ipv4_to_bastion_hosts" {
  security_group_id = aws_security_group.AppSG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  tags = {
    "Name" = "bastion_outgoing_ssh_ipv4_from_bastion_hosts"
  }
}
