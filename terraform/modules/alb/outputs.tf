output "alb_dns_name" {
  value = aws_lb.lb-1.dns_name
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.lb-tg-1.arn
}

