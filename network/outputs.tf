# Needed otherwise you cannot output these at upper level outputs.tf
output "vpc_id" {
    value = aws_vpc.main.id
    description = "The generated vpc id"
}

# output "subnet_publicA_id" {
#   value = aws_subnet.publicA.id
# }

# output "subnet_publicB_id" {
#   value = aws_subnet.publicB.id
# }

# output "subnet_publicC_id" {
#   value = aws_subnet.publicC.id
# }

# output "subnet_appA_id" {
#   value = aws_subnet.appA.id
# }

# output "subnet_appB_id" {
#   value = aws_subnet.appB.id
# }

# output "subnet_appC_id" {
#   value = aws_subnet.appC.id
# }