This workspace contains a minimal Terraform scaffold to create a site-to-site BGP VPN in AWS for a single `dev` environment.

Files:
- `versions.tf` - Terraform & provider constraints
- `providers.tf` - AWS provider configuration
- `variables.tf` - Variables including customer gateway IP and ASN
- `main.tf` - VPC, subnet, internet gateway, VPN gateway, customer gateway, VPN connection, route propagation, and security group
- `outputs.tf` - Useful outputs (VPN ID, config file path, VPC ID, EC2 Public IP)
- `envs/dev/examples.tfvars` - Fill in your `customer_gateway_ip`, `sg_key_pair`, and optionally `customer_gateway_asn`

Quick start:
1. Fill `envs/dev/examples.tfvars` with your public IP, ASN, and Key Pair.
2. Export AWS credentials (or configure them via your preferred method):

```powershell
$env:AWS_PROFILE = 'your-profile'
# or set AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION
```

3. Initialize providers:

```powershell
terraform init
```

4. Preview the plan:

```powershell
terraform plan -var-file=envs/dev/examples.tfvars
```

5. Apply (creates resources in AWS):

```powershell
terraform apply -var-file=envs/dev/examples.tfvars
```

After apply completes, the VPN configuration XML will be written into the workspace as shown in the `vpn_configuration_file` output. Use that file to configure your on-prem VPN device (it contains the tunnel endpoints, pre-shared keys, and BGP details).


