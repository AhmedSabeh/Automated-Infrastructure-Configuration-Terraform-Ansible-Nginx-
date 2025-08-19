variable "project"          { type = string }
variable "vpc_id"           { type = string }
variable "subnet_ids"       { type = list(string) }
variable "instance_type"    { type = string }
variable "target_group_arn" { type = string }
variable "public_key_path"  { type = string }
