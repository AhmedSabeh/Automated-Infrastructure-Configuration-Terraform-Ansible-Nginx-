module "vpc" {
  source         = "./modules/vpc"
  project        = var.project
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
}

module "alb" {
  source         = "./modules/alb"
  project        = var.project
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.public_subnet_ids
}

module "asg" {
  source             = "./modules/asg"
  project            = var.project
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  instance_type      = var.instance_type
  public_key_path    = var.public_key_path
  target_group_arn   = module.alb.alb_target_group_arn
}

