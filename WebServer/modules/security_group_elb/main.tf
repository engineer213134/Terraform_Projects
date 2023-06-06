#This is the security group folder

resource "aws_security_group" "elb_http" {
  name        = var.elb_security_group_name
  description = var.elb_security_group_description

  vpc_id = aws_vpc.my_vpc.id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.elb_ingress_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.elb_egress_cidr_block]
  }

  tags = {
    Name = "Allow HTTP through ELB Security Group"
  }
}