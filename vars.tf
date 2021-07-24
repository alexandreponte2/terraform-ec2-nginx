variable "amis" {
  type = map(string)

  default = {
    "us-east-1" = "ami-09e67e426f25ce0d7"
    "us-east-2" = "ami-09e67e426f25ce0d7"
  }
}

variable "cdirs_acesso_remoto" {
  type    = list(string)
  default = ["Seu-IP-Aqui/32"]
}
