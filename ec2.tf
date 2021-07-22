resource "aws_instance" "web1" {
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  user_data     = file("script.sh")
  tags = {
    Name = "web1"
  }

  vpc_security_group_ids = [aws_security_group.webapp.id]
}