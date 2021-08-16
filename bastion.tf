# Create a Bastion EC2
# Create Bastion Security Group
# Add AMI Amazon Linux Id
# Add PubSubnet ID
# Add Bastion Security Group ID
# Launch Keypair (SSH-Keygen local)
# Copy the keypair into pem file
# tag the name

resource "aws_key_pair" "tfm-key" {
  key_name   = "tfm-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0FuVQaX7DfUHLthxpoAr5qnv5wnJlEmRU6ZXAmCQjgR8xqoM0co0X09D6r22mrX1xY7XQ6ff80mKXojN5KZE+Yt+KBh356SRDh6xFT6RCJX+Bdc9pC/fgEsRPxaUbZY7y+75koLvVInydMOuWAq0Xmn27wLGfrt1ubxImkDrx437o1AzJPM7J/eFzYIelEK00E8EfylCBNLR7xGy4fHlh5vAOPx3jiSzvpYpWCKG84s2HE5GCv65mN+7nZVu45agN1+Uty7+ns8sFaFX1YbVYI4ArocDQWj9b5epIM5a+FIl0ngG/Hi3qRqO6yDTRg61TWhDnwqhqlMiwTS/TwoHPGptaIN1ou6p9mcjbbUtAECRBTEh2VvaTHrjT1RrhS13b9ewTizXGjNUUKQAQb8WaRNIbQjqfP99rjmZttAc8U/g+Im92etsTl8a4vJZ2O7HEMtF3Hq+1n2YK3NTES0YIUe8ffG62B+ZrLCp9Tw2sY29SEHprIKesEAh9MDyqW0s= sadip@DESKTOP-QKCDAO8"
} 

resource "aws_instance" "bastion-stg"{
  ami             = "ami-04db49c0fb2215364"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public-subnets[0].id
  security_groups = ["${aws_security_group.bastion-security-roup.id}"]
  key_name        = "${aws_key_pair.tfm-key.id}"
  tags = {
    Name = "bastion-stg"
  }
}
