aws_region = "us-west-2"

vpc_cidr = "10.30.0.0/16"

subnet_cidr = "10.30.15.0/24"

customer_gateway_ip = "YOUR_ON_PREM_PUBLIC_IP"

customer_gateway_asn = 65535 # Example ASN for customer gateway

vpn_connection_name = "dev-s2s-vpn"

sg_key_pair = "your-key-pair-name"

ec2_instance_name = "dev-ec2"

ec2_instance_type = "t3.micro"