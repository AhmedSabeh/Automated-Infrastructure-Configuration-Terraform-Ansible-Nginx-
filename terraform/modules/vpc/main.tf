data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc-1" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${var.project}-vpc", Project = var.project }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-1.id
  tags   = { Name = "${var.project}-igw", Project = var.project }
}

# Create one public subnet per AZ (limit by the number of CIDRs provided)
resource "aws_subnet" "public" {
  for_each                = { for idx, cidr in var.public_subnets : idx => cidr }
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[tonumber(each.key)]
  tags = {
    Name    = "${var.project}-public-${each.key}"
    Project = var.project
    Tier    = "public"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc-1.id
  tags   = { Name = "${var.project}-public-rt", Project = var.project }
}

resource "aws_route" "public_inet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

