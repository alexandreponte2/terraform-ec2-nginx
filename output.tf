output "dns" {
  value = aws_instance.web1.public_dns
}

# acessar apenas com http, já que é apenas um teste.