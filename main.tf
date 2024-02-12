provider "aws" {
    region = var.region
}

module "network" {
    source = "./network"
}
