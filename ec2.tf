# use data source to get a registered amazon linux 2 ami
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "boss-bation-hot-server1" {
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.boss-publicsubnet2.id
  key_name = "postgreskey"
  vpc_security_group_ids = [aws_security_group.boss-bastion-host-security-group.id]
  tags = {
    Name = "bastion for rds"
  }
}
 

resource "aws_instance" "boss-web-server1" {
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.boss-privatesubnet1.id
  key_name = "postgreskey"
  user_data              = file("installtachmax.sh")
  vpc_security_group_ids = [aws_security_group.boss-alb-security-group.id]
  tags = {
    Name = "web server for techmax"
  }
}
resource "aws_network_interface" "boss-network-interface1" {
  subnet_id   = aws_subnet.boss-privatesubnet1.id

  tags = {
    Name = "boss-network-interface1"
  }
}

resource "aws_instance" "boss-web-server2" {
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.boss-privatesubnet2.id
  key_name = "postgreskey"
  user_data              = file("installtachmax.sh")
  vpc_security_group_ids = [aws_security_group.boss-alb-security-group.id]
  tags = {
    Name = "web server for techmax"
  }
}

resource "aws_network_interface" "boss-network-interface2" {
  subnet_id   = aws_subnet.boss-privatesubnet2.id

  tags = {
    Name = "boss-network-interface2"
  }
}


resource "aws_instance" "boss-app-server1" {
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.boss-privatesubnet3.id
  key_name = "postgreskey"
  vpc_security_group_ids = [aws_security_group.boss-app-server-security-group.id]
  tags = {
    Name = "appserver for techmax"
  }
}

resource "aws_instance" "boss-app-server2" {
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.boss-privatesubnet4.id
  key_name = "postgreskey"
  vpc_security_group_ids = [aws_security_group.boss-app-server-security-group.id]
  tags = {
    Name = "appserver for techmax"
  }
}


