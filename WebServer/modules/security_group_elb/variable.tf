variable "elb_security_group_name" {
  description = "The name of the ELB security group"
  default     = "elb_http"
}

variable "elb_security_group_description" {
  description = "The description of the ELB security group"
  default     = "Allow HTTP traffic to instances through Elastic Load Balancer"
}

variable "elb_ingress_cidr_block" {
  description = "The CIDR block for ELB ingress traffic"
  default     = "0.0.0.0/0"
}

variable "elb_egress_cidr_block" {
  description = "The CIDR block for ELB egress traffic"
  default     = "0.0.0.0/0"
}