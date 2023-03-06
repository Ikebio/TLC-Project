# Security group
resource "aws_security_group" "feb-sg" {
  name        = "ec2 security group"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"


 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }


 ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# Instance 

resource "aws_instance" "feb-pub-ec2" {
  ami = "ami-0d09654d0a20d3ae2"
  instance_type = "t3.micro"
  count = 1
  vpc_security_group_ids =  ["${aws_security_group.feb-sg.id}"]
  subnet_id = aws_subnet.pub1.id
  key_name = "nc"
  associate_public_ip_address = "true"
  tags = {
    Name = "TLC Pub EC2"
  }
}

resource "aws_instance" "feb-priv-ec2" {
  ami = "ami-0d09654d0a20d3ae2"
  instance_type = "t3.micro"
  count = 1
  vpc_security_group_ids = ["${aws_security_group.feb-sg.id}"]
  subnet_id = aws_subnet.priv1.id
  key_name = "nc"
  associate_public_ip_address = "false"
  tags = {
    Name = "TLC Priv EC2"
  }
}