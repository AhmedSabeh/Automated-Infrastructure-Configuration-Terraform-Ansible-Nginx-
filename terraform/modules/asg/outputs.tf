output "asg_name" {
  value = aws_autoscaling_group.asg-1.name
}

output "ec2_sg_id" {
  value = aws_security_group.asg_sg.id
}

