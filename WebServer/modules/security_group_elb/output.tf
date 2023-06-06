#Used to be able to referance in the elb resourse
output "security_group_id" {
  value = aws_security_group.elb_http.id
}