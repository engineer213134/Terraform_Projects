variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "security_group_name" {
  description = "The name of the security group"
}

variable "security_group_desc" {
  description = "The description of the security group"
}

variable "security_group_ingress_cidr" {
  description = "The CIDR block for ingress traffic"
}
