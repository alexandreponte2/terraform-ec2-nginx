data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*-amd64-server-*"]
  }

# ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230208
#ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230208
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

output "test" {
  value = data.aws_ami.ubuntu
}



# utilizando data para pegar a imagem mais recente do ubuntu.

resource "aws_instance" "web1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data     = file("script.sh")
  tags = {
    Name = "web12"
  }

  vpc_security_group_ids = [aws_security_group.webapp.id]
}