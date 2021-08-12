# create tomcat server
# add ami liunx
# selete instance type
#selete the private subnet id
#add  the tomcat sg id
#launch the key pair(ssh-keygen local)
# copy the key pair into pem file
#tag the name 


data "template_file" "userr_data" {
  template = "${file("tomcat_install.sh")}"
}

resource "aws_instance" "tomcat" {
  ami             = "ami-00bf4ae5a7909786c"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private-subnet-1.id
  security_groups = ["${aws_security_group.tomcat-security-group.id}", "${aws_security_group.bastion-security-roup.id}"]
  key_name        = "${aws_key_pair.petclinic.id}"
  user_data       = data.template_file.userr_data.rendered
  tags = {
    Name = "tomcat"
  }
}













