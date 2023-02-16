# variable "amis" {
#   type = map(string)
# #Altere a imagem conforme a região
# # aqui estamos usando a imagem do ubuntu devido ao script.ssh
#   default = {
#     "us-east-1" = "ami-0557a15b87f6559cf"
#     "us-east-2" = "ami-08c40ec9ead489470"
#   }
# }

variable "cdirs_acesso_remoto" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

#Recomendo configurar um profile
#https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html
variable "aws_profile" {
  type        = string
  description = " "
  default     = "playground"
}
