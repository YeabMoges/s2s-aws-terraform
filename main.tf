resource "aws_vpc" "dev" {
  cidr_block = var.vpc_cidr
  tags       = { Name = "dev-vpc" }
}

resource "aws_subnet" "dev" {
  vpc_id            = aws_vpc.dev.id
  cidr_block        = var.subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags              = { Name = "dev-subnet" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev.id
  tags   = { Name = "dev-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "dev-public-rt" }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.dev.id
  route_table_id = aws_route_table.public.id
}

resource "aws_vpn_gateway" "vgw" {
  vpc_id = aws_vpc.dev.id
  tags   = { Name = "dev-vgw" }
}

resource "aws_customer_gateway" "cgw" {
  bgp_asn    = var.customer_gateway_asn
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"
  tags       = { Name = "dev-cgw" }
}

resource "aws_vpn_connection" "vpn" {
  customer_gateway_id = aws_customer_gateway.cgw.id
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  type                = "ipsec.1"
  static_routes_only  = false

  tags = { Name = var.vpn_connection_name }
}

resource "aws_vpn_gateway_route_propagation" "propagation" {
  vpn_gateway_id = aws_vpn_gateway.vgw.id
  route_table_id = aws_route_table.public.id
}

resource "local_file" "vpn_config" {
  content  = aws_vpn_connection.vpn.customer_gateway_configuration
  filename = "${path.module}/dev-vpn-configuration-${aws_vpn_connection.vpn.id}.xml"
}

resource "aws_security_group" "dev_sg" {
  name   = "dev-sg"
  vpc_id = aws_vpc.dev.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "dev-sg" }
}

resource "aws_instance" "app" {
  ami                         = data.aws_ssm_parameter.al2023_amd64.value
  instance_type               = var.ec2_instance_type
  vpc_security_group_ids      = [aws_security_group.dev_sg.id]
  subnet_id                   = aws_subnet.dev.id
  key_name                    = var.sg_key_pair
  associate_public_ip_address = true

  tags = {
    Name = var.ec2_instance_name
  }
}
