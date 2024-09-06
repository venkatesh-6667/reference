# variables.tf

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "The CIDR block for the VPC"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
  description = "The CIDR block for the subnet"
}

variable "instance_type" {
  default = "t3.medium"
  description = "EC2 instance type"
}

variable "ami_id" {
  default = "ami-04505e74c0741db8d" # Ubuntu 20.04 in us-east-1
  description = "AMI ID to use for the instance"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
  description = "Path to the public SSH key"
}
