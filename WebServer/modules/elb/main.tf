//This is the main for the elastic load balancer 

# Create a new load balancer
resource "aws_elb" "bar" {
  name               = "ELB project"
  count         = length(var.availability_zones)
  availability_zones = var.availability_zones[count.index]


listener {
  instance_port     = var.instance_port
  instance_protocol = var.instance_protocol
  lb_port           = var.lb_port
  lb_protocol       = var.lb_protocol
}


health_check = var.health_check_config
load_balancer_config = var.load_balancer_config

  tags = {
    Name = "terraform-elb"
  }
}