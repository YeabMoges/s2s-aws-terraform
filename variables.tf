variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "customer_gateway_ip" {
  description = "Public IP address of customer gateway."
  type        = string
}

variable "customer_gateway_asn" {
  description = "BGP ASN of your customer gateway device."
  type        = number
}

variable "vpn_connection_name" {
  description = "Name tag for the VPN connection"
  type        = string
}

variable "sg_key_pair" {
  description = "Key Pair for Security Group"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ec2_instance_name" {
  description = "dev-ec2"
  type        = string

}
