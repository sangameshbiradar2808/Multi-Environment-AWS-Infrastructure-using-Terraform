variable "aws_region" {
  description = "AWS region where resources will be created."
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name. Use dev, staging, or prod."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for two public subnets."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Provide exactly two public subnet CIDR blocks."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for two private subnets."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Provide exactly two private subnet CIDR blocks."
  }
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway for private subnet outbound access."
  type        = bool
  default     = false
}
