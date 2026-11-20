# Multi-Environment AWS Infrastructure using Terraform

A beginner-friendly Terraform project that provisions the same AWS network architecture for
`dev`, `staging`, and `prod` with environment-specific settings.

## What it creates

- A custom VPC
- Two public subnets in separate Availability Zones
- Two private subnets in separate Availability Zones
- An Internet Gateway and public route table
- Optional NAT Gateway for private-subnet outbound access
- Environment-specific tags and CIDR ranges

> Cost warning: NAT Gateways and their data processing incur AWS charges. The `dev` and
> `staging` examples disable NAT to reduce cost. The `prod` example enables one NAT Gateway.
> Review current AWS pricing before applying.

## Prerequisites

- An AWS account
- AWS CLI installed and configured (`aws configure`)
- Terraform installed
- IAM permissions to create VPC, subnet, route table, Internet Gateway, and NAT Gateway resources

Check your setup:

```bash
aws sts get-caller-identity
terraform version
```

## Project structure

```text
multi-environment-aws-terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── terraform.tfvars.example
├── environments/
│   ├── dev.tfvars
│   ├── staging.tfvars
│   └── prod.tfvars
└── .gitignore
```

## Deploy the DEV environment

Open a terminal in this project directory:

```bash
terraform init
terraform workspace new dev
terraform plan -var-file="environments/dev.tfvars"
terraform apply -var-file="environments/dev.tfvars"
```

If the `dev` workspace already exists, use:

```bash
terraform workspace select dev
```

## Deploy STAGING

```bash
terraform workspace new staging
terraform plan -var-file="environments/staging.tfvars"
terraform apply -var-file="environments/staging.tfvars"
```

If it already exists:

```bash
terraform workspace select staging
```

## Deploy PROD

```bash
terraform workspace new prod
terraform plan -var-file="environments/prod.tfvars"
terraform apply -var-file="environments/prod.tfvars"
```

If it already exists:

```bash
terraform workspace select prod
```

## Check resources and outputs

```bash
terraform workspace list
terraform output
```

## Destroy an environment

Select the environment first, then run the matching destroy command:

```bash
terraform workspace select dev
terraform destroy -var-file="environments/dev.tfvars"
```

Use the corresponding `staging.tfvars` or `prod.tfvars` file for those environments.
Double-check the selected workspace and plan before destroying anything.

## Important state-management note

Terraform CLI workspaces share one backend configuration. Workspaces provide separate state
instances, but they are not a complete security boundary. For production/team use, configure
separate remote state storage and access controls for each environment (for example, separate
S3 state keys/buckets and a locking strategy supported by your Terraform version).

This starter uses local state so it can be practiced without first creating a remote state bucket.
Do not commit Terraform state files, plan files, or AWS credentials to GitHub.

## Customize

Edit the relevant `.tfvars` file to change the environment name, VPC CIDR, subnet CIDRs,
or whether a NAT Gateway is created. The AWS region defaults to `ap-south-1`.
