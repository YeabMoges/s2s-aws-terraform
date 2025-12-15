provider "aws" {
  region = var.aws_region
  profile = "YOUR_AWS_PROFILE_NAME"
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ssm_parameter" "al2023_amd64" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}
