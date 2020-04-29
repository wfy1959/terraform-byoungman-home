provider "aws" {
  profile    = "default"
  region     = production.region
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-2c"

  tags = {
    Name = "Default subnet for us-east-2"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-097834fcb3081f51a"
  instance_type = "t2.micro"
  
  provisioner "local-exec" {
  command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}