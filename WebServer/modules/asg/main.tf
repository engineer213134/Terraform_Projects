#Main file for the ASG

resource "aws_autoscaling_group" "web_as_group" {
  name              = "example-asg"
  desired_capacity  = var.desired_capacity
  min_size          = 1
  max_size          = 5
  launch_template {
    id      = aws_launch_template.terramino.id
    version = "$Latest"
  }
  vpc_zone_identifier       = "${var.subnets}"

  #Have to referance the ELB i created
  load_balancers = [aws_elb.web_elb.id]
}

#Change this to a launch template https://docs.aws.amazon.com/autoscaling/ec2/userguide/launch-templates.html
resource "aws_launch_template" "terramino" {
  name_prefix       = "learn-terraform-aws-asg-"
  image_id          = var.ami_id
  instance_type     = var.instance_type
  user_data = var.instance_user_data  
  
  #Need to create a security group
  security_group_ids = [aws_security_group.terramino_instance.id]

  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}
