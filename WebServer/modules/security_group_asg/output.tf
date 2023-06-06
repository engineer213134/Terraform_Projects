#Used to be able to referance in the asg resourse
output "security_group_id" {
  value = aws_security_group.asg_http.id
}