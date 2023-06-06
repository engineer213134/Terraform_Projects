variable "ami_id" {
  description = "AMI ID for the Amazon Linux image"
  type        = string
  default     = "ami-xxxxxxxx"  # Replace with your desired default AMI ID
}


variable "instance_type" {
  description = "Instance type for the launch configuration"
  type        = string
}

variable "instance_user_data" {
  type        = string
  description = "User data for EC2 instance initialization"
  default     = <<-EOT
    #!/bin/bash
    echo "Hello, World!"
    # Additional script commands...
  EOT
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets for the ASG"
  type    = list(string)
  default = ["subnet-xxxxxx", "subnet-xxxxxx"]
}


