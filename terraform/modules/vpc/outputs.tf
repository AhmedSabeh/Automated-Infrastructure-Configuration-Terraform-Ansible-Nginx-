output "vpc_id" {
  value = aws_vpc.vpc-1.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

