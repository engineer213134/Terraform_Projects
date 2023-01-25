#Creating a load balancer this will allow you to deploy traffic amoung servers
#There are 3 types of load balancers ALB,NLB,CLB
#This will be a ALB(Application load balancer)
#ALB consists of several parts: Listner,Listner Rule,Target groups,

#First create the ALB resource:

resource "aws_lb" "example" {
    name                = "terraform-asg-example"
    load_balancer_type  = "application"
    subnets             = data.aws_subnets.default.ids #subnets parameter us using the Defualt VPC using aws_subnets data source
}


#Define a ALB listner

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.example.arn
    port = 80
    protocol = "HTTP"

    #Defulat send 404 page
    default_action {
        type = "fixed-response"

        fixed_response {
            content_type = "text/plain"
            message_body = "404: page not found"
            status_code = 404
          
        }
    }
}

#Need to create a security group since by defualt all ALB do not incoming/outcoming traffic

#AWS security group

resource "aws_security_group" "alb" {

    name = "terraform-example-alb"

    #Allow inbounb HTTP requests

    ingress = {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }

    #Allow all outbound requests

    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_block = ["0.0.0.0/0"]

    }
}

#Once security group is created you need to tell the aws_lb resources to use the security group

resource "aws_lb" "example" {

    name                = "terraform-asg-example"
    load_balancer_type  = "application"
    subnets             = data.aws_subnets.default.ids
    security_groups     =  [aws_security_group.alb.id]
}


#Create a target group for the ASG(Auto scalling group)

resource "aws_lb_target_group" "asg" {
    name = "terraform-asg-example"
    port = var.server_port
    protocol = "HTTP"
    vpc_id = data.aws_vpc.default.id

    health_check {
        path =  "/"
        protocol = "HTTP"
        matcher = "200"
        interval = 15
        timeout = 3
        healthy_threshold = 2
        unhealthy_threshold = 2
    }
}

#How does target group know which EC2 instances to send requests to? Instead, 
#you can take advantage of the first-class integration between the ASG and the ALB.

resource "aws_autoscaling_group" "example" {
    launch_configuration = aws_launch_configuration.example.name
    vpc_zone_identifier = data.aws_subnets.default.ids

    target_group_arns = [aws_lb_target_group.asg.arn]
    health_check_type = "ELB"


    min_size = 2
    max_size = 10

    tag {
        key = "Name"
        value =   "terraform-asg-example"
        propagate_at_launch = true
    }
}


#Create listner rules

resource "aws_lb_listener_rule" "asg" {
    listener_arn = aws_lb_listener.http.arn
    priority     = 100

    condition {
      path_pattern {
        values = ["*"]
      }
    }
    action {
      type = "forward"
      target_group_arn = aws_lb_target_group.asg.arn
    }
}







