variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "instance_port" {
  type    = number
  default = 80
}

variable "instance_protocol" {
  type    = string
  default = "http"
}

variable "lb_port" {
  type    = number
  default = 80
}

variable "lb_protocol" {
  type    = string
  default = "http"
}
variable "health_check_config" {
  type = object({
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout             = number
    target              = string
    interval            = number
  })
  default = {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }
}
variable "load_balancer_config" {
  type = object({
    instances                   = list(string)
    cross_zone_load_balancing   = bool
    idle_timeout                = number
    connection_draining         = bool
    connection_draining_timeout = number
  })
  default = {
    instances                   = []
    cross_zone_load_balancing   = true
    idle_timeout                = 400
    connection_draining         = true
    connection_draining_timeout = 400
  }
}
