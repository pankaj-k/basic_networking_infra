# Needed otherwise you cannot output these at upper level outputs.tf
output "vpc_id" {
    value = aws_vpc.main.id
    description = "The generated vpc id"
}