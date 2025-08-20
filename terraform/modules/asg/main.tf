data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Import your SSH public key
resource "aws_key_pair" "my-key" {
  key_name   = "my-key"
  public_key = file(var.public_key_path)
}

# Security group for EC2
resource "aws_security_group" "asg_sg" {
  name        = "asg-sg"
  description = "ASG security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch template
resource "aws_launch_template" "template-1" {
  name_prefix   = "lt-1"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.my-key.key_name
  vpc_security_group_ids = [aws_security_group.asg_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "vm-lt-1"
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "asg-1" {
  name                      = "asg"
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 3
  vpc_zone_identifier       = var.subnet_ids
  health_check_type         = "EC2"
  health_check_grace_period = 60

  launch_template {
    id      = aws_launch_template.template-1.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]
}


resource "aws_autoscaling_attachment" "alb" {
  autoscaling_group_name = aws_autoscaling_group.asg-1.id
  lb_target_group_arn   = var.target_group_arn
}
