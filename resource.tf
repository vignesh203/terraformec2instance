resource "aws_key_pair" "mykey" {
  key_name   = "${var.PROJECT}-deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMm8qvwCY7wozq298L5eM0na37H03/ResTsdXDIuV6Pm4AXM55iMo7p0tzwS+BK3Eni2ywOKlyXMSQwKFiwS/bcB95DxdrvBWh2xNkAp8hhmfHETNBKxXgvl19n+zr+LNRN6KErdKlpMraN0aC2hguj+3AqohdZjGcQqe4c7yfq4GXhkNJGQ2V2iPM0Bo3LtBptjFCkGIZ+Kj9IJ6VtVK3g1WftPi4TGQ09oMYU4ydvEwAAqpcHraCSQj8SixGJpYI/KnGU2g7DW8j1iY5xlvfKDyi8r1jB85aQjfLQ2WB/2z62YYHRCVplkCx/3oQEEileIYtxLDW0SrHhVzhG8Ow62qXw1fxDFMrDlzyh2+nwcmEUMpPagZWzwHY0juYqldqjyJB4llkaP45h8DapFcDV67/szYNYzmxaQdGWC6TNSoWWMYe5oirpLknpzk055ieJhi/eYuGfFJtki+H/4GnQLx3KKlnQ8mEvOTZ6dPJ6QKMoHi09Y7E2sFwWZw9PiU= AzureAD+VigneshMuthiyapillai@PC-VigneshMuthiyapillai"
}

resource "aws_security_group" "allow_tls" {
  name        = "${var.PROJECT}-securitygroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.VPC_ID

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


resource "aws_instance" "web" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id              = var.SUBNET_ID

  tags = {
    Name = "${var.PROJECT}-instancename"
  }
}
