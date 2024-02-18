# Get latest Amazon Linux AMI
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}

# Call the external data source once only to get the latest ami
locals {
  ami_id = data.aws_ami.amzlinux2.id  
}

resource "aws_instance" "bastion_publicA" {
  ami           = local.ami_id 
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.BastionSG.id]
  subnet_id = aws_subnet.publicA.id
  tags = {
    Name = "Bastion A"
  }
}

resource "aws_instance" "bastion_publicB" {
  ami           = local.ami_id 
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.BastionSG.id]
  subnet_id = aws_subnet.publicB.id
  tags = {
    Name = "Bastion B"
  }
}

resource "aws_instance" "bastion_publicC" {
  ami           = local.ami_id 
  vpc_security_group_ids = [aws_security_group.BastionSG.id]
  instance_type = "t3.micro"
  subnet_id = aws_subnet.publicC.id
  tags = {
    Name = "Bastion C"
  }
}

resource "aws_instance" "appA" {
  ami           = local.ami_id 
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.AppSG.id]
  subnet_id = aws_subnet.appA.id
  tags = {
    Name = "App A"
  }
}

resource "aws_instance" "appB" {
  ami           = local.ami_id 
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.AppSG.id]
  subnet_id = aws_subnet.appB.id
  tags = {
    Name = "App B"
  }
}

resource "aws_instance" "appC" {
  ami           = local.ami_id 
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.AppSG.id]
  subnet_id = aws_subnet.appC.id
  tags = {
    Name = "App C"
  }
}