# Terraform para iniciantes.
 ![Where is the doctor](/images/terraformicon.png)



Terraform é uma ferramenta para construir, alterar e configurar infraestrutura.
Isso pode ser feito tanto localmente quanto remoto.


_Alguns exemplos de nuvens públicas que podemos trabalhar utilizando o terraform, [clique aqui](https://registry.terraform.io/browse/providers)_

Neste post vamos utilizar aws por causa do [free tier](https://aws.amazon.com/pt/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all)

Para nos comunicarmos com a aws, vamos precisar de duas chaves _aws_access_key_ e _aws_secret_key_, essas chaves podem ser configuradas via [aws-cli](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/install-cliv2.html)
você precisa configura-las na sua máquina.



### Mãos a obra.

Recomendo você criar uma pasta para podermos trabalhar, após isso dentro dessa pasta crie os seguintes arquivos.


main.tf
ec2.tf
output.tf
script.sh
security-group.tf
vars.tf
terraform.tfvars



#### No arquivo main.tf, iremos incluir o nosso provider aws.

```
provider "aws" {
  region = "us-east-1"
}
```


#### No arquivo ec2.tf, vamos declarar a nossa instancia, aqui estamos citando o script.sh que irá instalar o nginx.
#### Aqui também citamos o security group e que vai se comportar como um firewall para a nossa instancia


```
resource "aws_instance" "web1" {
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  user_data     = file("script.sh")
  tags = {
    Name = "web1"
  }

  vpc_security_group_ids = [aws_security_group.web1.id]
}
```

#### O output.tf utilizamos para que no final da execução do nosso código nos seja apresentado alguma informação desejada.
#### No caso aqui será a url para acessarmos a instancia via browser.

```
output "dns" {
  value = aws_instance.web1.public_dns
}
```

#### Através do security-group.tf declaramos as portas que estaram abertas de entrada e saida.
#### Também podemos limitar esses acessos via ip.
#### Estamos utilizando variável para facilitarmos o nosso dia, caso precise alterar o ip de acesso, alteramos em apenas um lugar.

```
resource "aws_security_group" "web1" {
  name        = "web1"
  description = "Allow web"

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cdirs_acesso_remoto
  }
  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = var.cdirs_acesso_remoto
  }
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = var.cdirs_acesso_remoto
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web1"
  }
}
```

#### As variáveis citadas acima, serão declaras no arquivo vars.tf.

```
variable "amis" {
  type = map(string)

  default = {
    "us-east-1" = "ami-09e67e426f25ce0d7"
    "us-east-2" = "ami-09e67e426f25ce0d7"
  }
}

variable "cdirs_acesso_remoto" {
  type    = list(string)
  default = ["seu-ip/32"]
}
```

**um poucos sobre os comandos que serão executados**

_[terraform init](https://www.terraform.io/docs/cli/commands/init.html)_

_[terraform plan](https://www.terraform.io/docs/cli/commands/plan.html)_

_[terraform apply](https://www.terraform.io/docs/cli/commands/apply.html)_




