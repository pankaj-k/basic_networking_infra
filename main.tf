provider "aws" {
  region = var.region
}

# Decided on region above and now going to get the availiablity zones in that.
data "aws_availability_zones" "available" {}

# Want to tag the subnets with A, B and C initials
locals {
  zone_initials = {
    0 = "A",
    1 = "B",
    2 = "C"
  }
}

resource "aws_vpc" "koffee_luv_vpc" {
  cidr_block                       = "172.16.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  tags = {
    "Name" = "koffee-luv-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  # If the AZ's in a region count comes to be more than 3, then limit the count to 3. 
  count                   = length(data.aws_availability_zones.available.names) > 3 ? 3 : length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.koffee_luv_vpc.id
  cidr_block              = "172.16.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public${lookup(local.zone_initials, count.index)}"
  }
}

resource "aws_subnet" "private_subnet_apps" {
  # If the AZ's in a region count comes to be more than 3, then limit the count to 3. 
  count             = length(data.aws_availability_zones.available.names) > 3 ? 3 : length(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.koffee_luv_vpc.id
  cidr_block        = "172.16.${4 + count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "App${lookup(local.zone_initials, count.index)}"
  }
}

resource "aws_subnet" "private_subnet_db" {
  # If the AZ's in a region count comes to be more than 3, then limit the count to 3. 
  count             = length(data.aws_availability_zones.available.names) > 3 ? 3 : length(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.koffee_luv_vpc.id
  cidr_block        = "172.16.${8 + count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "Db${lookup(local.zone_initials, count.index)}"
  }
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.koffee_luv_vpc.id
}
