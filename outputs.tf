output "vpn_connection_id" {
  value = aws_vpn_connection.vpn.id
}

output "vpn_configuration_file" {
  value       = local_file.vpn_config.filename
  description = "Local path to the downloaded VPN configuration XML file"
}

output "vpc_id" {
  value = aws_vpc.dev.id
}

output "ec2_instance_name" {
  value = var.ec2_instance_name
}
output "ec2_public_ip" {
  value = aws_instance.app.public_ip
}
