# This is the main for the elastic load balancer

# Create a new load balancer
resource "aws_elb" "web_elb" {
  name                     = "ELB project"
  count                    = length(var.availability_zones)
  availability_zones       = var.availability_zones[count.index]
  health_check             = var.health_check_config
  load_balancer_config     = var.load_balancer_config
  # Need to reference the module
  security_groups          = [security_group.security_group_id]
  cross_zone_load_balancing = true

  listener {
    instance_port     = var.instance_port
    instance_protocol = var.instance_protocol
    lb_port           = var.lb_port
    lb_protocol       = var.lb_protocol
  }
  
  tags = {
    Name = "terraform-elb"
  }
}
