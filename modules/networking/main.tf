# -------  modules/networking/main.tf
resource "aws_vpc" "project" {
  cidr_block       = var.vpc_cidr #our cidr is now a variable. 
  instance_tenancy = var.vpc_instance_tenancy
  tags = {
    Name = "Project"
  }
}

resource "aws_internet_gateway" "project_gw" {
  vpc_id = aws_vpc.project.id

  tags = {
    Name = "Project"
  }
}
data "aws_availability_zones" "available" {
}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = 3
}

resource "aws_subnet" "public_project_subnet" {
  count             = var.public_sn_count
  vpc_id            = aws_vpc.project.id
  cidr_block        = var.public_cidrs[count.index]
  availability_zone = random_shuffle.az_list.result[count.index]
  tags = {
    Name = "project public ${count.index}"
  }
}

resource "aws_subnet" "private_project_subnet" {
  count             = var.private_sn_count
  vpc_id            = aws_vpc.project.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = random_shuffle.az_list.result[count.index]
  tags = {
    Name = "project private ${count.index}"
  }
}

resource "aws_default_route_table" "internal_project_default" {
  default_route_table_id = aws_vpc.project.default_route_table_id

  route {
    cidr_block = var.default_rt_route_cidr_block
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "Project-internal-RT"
  }
}


resource "aws_route_table" "public_project_route_table" {
  vpc_id = aws_vpc.project.id

  route {
    cidr_block = var.public_route_cidr_block
    gateway_id = aws_internet_gateway.project_gw.id
  }

  tags = {
    Name = "Project-External-RT"
  }
}

resource "aws_route_table_association" "public" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.public_project_subnet[count.index].id
  route_table_id = aws_route_table.public_project_route_table.id
}

resource "aws_route_table_association" "default" {
  count          = var.private_sn_count
  subnet_id      = aws_subnet.private_project_subnet[count.index].id
  route_table_id = aws_default_route_table.internal_project_default.id
}

resource "aws_eip" "elastic_ip" {
  vpc        = var.elastic_ip_vpc
  depends_on = [aws_internet_gateway.project_gw]
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_project_subnet[0].id

  tags = {
    Name = "gw NAT2"
  }

  depends_on = [aws_internet_gateway.project_gw]
}
