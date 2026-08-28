variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix used to name/tag all resources"
  type        = string
  default     = "skillexchange"
}

variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.20.11.0/24", "10.20.12.0/24"]
}

variable "azs" {
  description = "Availability zones to spread subnets across"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_name" {
  type    = string
  default = "skillexchange"
}

variable "db_username" {
  description = "RDS master username. Not a secret by itself — has a sensible default, override only if you want something else."
  type        = string
  default     = "admin"
}

# No db_password, ssh_public_key, or ssh_ingress_cidr variables anymore:
# - The DB password is generated automatically by Terraform (random_password
#   in rds.tf) and never leaves the AWS account — it's written straight into
#   the instance's systemd service and RDS, and never needs to be typed in,
#   stored as a GitHub secret, or seen by a human.
# - There's no SSH key pair or open port 22 at all. Deploys happen over AWS
#   Systems Manager (SSM), which authenticates using the instance's IAM role,
#   not a key you have to generate, store, and rotate.
