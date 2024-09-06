# main.tf

# Create VPC
resource "aws_vpc" "red5_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Red5VPC"
  }
}

# Create Subnet
resource "aws_subnet" "red5_subnet" {
  vpc_id            = aws_vpc.red5_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = "Red5Subnet"
  }
}

# Create Security Group
resource "aws_security_group" "red5_sg" {
  vpc_id = aws_vpc.red5_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5080
    to_port     = 5080
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
    Name = "Red5SecurityGroup"
  }
}

# Create EC2 instance
resource "aws_instance" "red5_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.red5_subnet.id
  security_groups        = [aws_security_group.red5_sg.name]
  key_name               = aws_key_pair.red5_key.key_name

  tags = {
    Name = "Red5Server"
  }

  # Provisioner to upload the script
  provisioner "file" {
    source      = "install_red5.sh"
    destination = "/home/ubuntu/install_red5.sh"
  }

  # Provisioner to run the uploaded script
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }

    inline = [
      "chmod +x /home/ubuntu/install_red5.sh",
      "sudo /home/ubuntu/install_red5.sh"
    ]
  }
}
