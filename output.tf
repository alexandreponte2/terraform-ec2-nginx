output "dns" {
  value = "http://${aws_instance.web1.public_dns}"
  # value = aws_instance.web12.public_dns
}



# acessar apenas com http, já que é apenas um teste.