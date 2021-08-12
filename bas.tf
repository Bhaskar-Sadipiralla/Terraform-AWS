# create bastion server
# add ami liunx
# selete instance type
#selete the public subnet id
#add  the bastion sg id
#launch the key pair(ssh-keygen local)
# copy the key pair into pem file
#tag the name 




resource "aws_instance" "bastion" {
  ami             = "ami-00bf4ae5a7909786c"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public-subnet-1.id
  security_groups = ["${aws_security_group.bastion-security-roup.id}"]
  key_name        = "${aws_key_pair.petclinic.key_name}"
  tags = {
    Name = "bastion"
  }
}













resource "aws_key_pair" "petclinic" {
  key_name   = "petclinic-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJlceIY3JeiY/Th1ve92j+RngxVwyeARqry9NycbkhYzgP96QNWljht5UW6gz6dk3+nMQhG41JWI13vWtlOgHSLMvsSkhzgzB3TdA58OYzVYW3QHrxiyG2Cl3dqaTquEFpme0TBA6+nXER8RSmcHGvHTwOH2HDn70skBmh9jUWPCaHpJ5D/D8/oUWNutmOj58dufnuMRgxSHAvRi4iSu25hgxZIpdCXaHx1xjwmF+alvBgPFbG/0YXQdfwjzoOMxPY5mdxA8D2VNS/in6YX2JR4CVoUK9q7SMAKrkhwAT+8oaSlsDMOhgxaK5lt6cLkrFRSyQbQ1F0U6S7isE4opAH reddy@nagesh"
}  