# AWS Elastic IP: Normal public IP allocated by AWS get replaced with new ones of restart. 
# Use Elastic IP to get a static IP. 
# As per documentation: 
# An Elastic IP address is a static, public IPv4 address designed for dynamic cloud computing. 
# You can associate an Elastic IP address with any instance or network interface in any VPC in your account. 
# With an Elastic IP address, you can mask the failure of an instance by rapidly remapping the address to another instance in your VPC.

# https://stackoverflow.com/questions/50306324/what-is-elastic-ip-in-aws-and-why-it-is-useful 
# https://kloudle.com/academy/5-things-to-consider-when-using-aws-elastic-ip-addresses 

# Remember: Release unused Elastic IP addresses. 
# An Elastic IP address associated with a running instance does not incur any charges. 
# But AWS charges an hourly fee for Elastic IP that is not associated with any instance. 

# EIP may require IGW to exist prior to association. BUT WHY?
# Use depends_on to set an explicit dependency on the IGW.

resource "aws_eip" "eip_nat_gatewayA" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "Elastic IP A"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "eip_nat_gatewayB" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "Elastic IP B"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "eip_nat_gatewayC" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "Elastic IP C"
  }
  lifecycle {
    create_before_destroy = true
  }
}
