#Aws launch configuration for auto scaling groups specifies how to create each EC2 instance in the ASG

resource "aws_launch_configuration" "example" {
    ami     = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"
    Security_groups = [aws_security_group.instance.id]


    user_data = <<-EOF
        #!/bin/bash
        echo "Hello, World" > index.xhtml
        nohup busybox httpd -f -p ${var.server_port} &
        EOF

    # Required when using a launch configuration with an auto scaling group, This stops incorrect deleating of a resource.
    lifecycle {
      create_before_destroy = true
    }
}

#Pulling aws subnets from your account
data "aws_subnets" "default" {
    filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
    }
}


#Creating the ASG
resource "aws_autoscaling_group" "example" {
    launch_configuration = aws_launch_configuration.example.name
    vpc_zone_identifier = data.aws_subnets.default.ids

    min_size = 2
    max_size = 10

    tag{
        key = "Name"
        value = "terraform-asg-example"
        propagate_at_launch = true
    }
}
