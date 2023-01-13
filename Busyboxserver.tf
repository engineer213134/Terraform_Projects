resource "aws_instance" "example" {
    ami     = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]

#You will want to use a referance in a string literal too inorder to use server port use ${...}
    user_data = <<-EOF
        #!/bin/bash
        echo "Hello, World" > index.xhtml
        nohup busybox httpd -f -p ${var.server_port} &
        EOF

    user_data_replace_on_change = true

    tags = {
        Name = "terraform-example"
    }
}

#Security Grouo 

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"

    ingress {
        from_port = var.server_port
        to_port   = var.server_port
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#Variable to store the web server port numbers for best practice
variable "server_port" {
    description = "The port the server will use for HTTP requests"
    type        = number
    default = 8080
}



      
