# NAT: A resource that allows initiating connections to the public internet from within 
# your network, but not the other way around.

# Egress-Only Internet Gateway - The IPv6 equivalent of a NAT Gateway (Not used here)

# You route traffic from the NAT gateway to the internet gateway for the VPC. 
# Hence the IGW (internet gateway) must exist prior to Nat gateway creation.
# So use depends_on for certainity in the order of resource creation.

# More reading at the end of this code.

resource "aws_nat_gateway" "nat_gatewayA" {
  allocation_id = aws_eip.eip_nat_gatewayA.id
  subnet_id     = aws_subnet.publicA.id
  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "NAT Gateway A"
  }
}

resource "aws_nat_gateway" "nat_gatewayB" {
  allocation_id = aws_eip.eip_nat_gatewayB.id
  subnet_id     = aws_subnet.publicB.id
  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "NAT Gateway B"
  }
}

resource "aws_nat_gateway" "nat_gatewayC" {
  allocation_id = aws_eip.eip_nat_gatewayC.id
  subnet_id     = aws_subnet.publicC.id
  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "NAT Gateway C"
  }
}

/* 
A NAT gateway is not an alternative to an internet gateway, they actually work in tandem. 
If you have an instance that needs internet access, you have two choices. 
You could route internet-bound traffic to the VPC's internet gateway, in which case traffic 
can go in both directions. Or you could route internet-bound traffic 
to the NAT gateway, in which traffic will be sent to the VPC's internet gateway 
and out to the public internet. But traffic cannot go in the other direction. 
Either way the internet-bound traffic will go through the internet gateway. 

A NAT gateway is attached to a subnet which is a bit different from an Internet Gateway which 
is attached to a VPC.

NAT gateway needs access to the internet gateway and hence it is always placed in public subnet.
*/