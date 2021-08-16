# create tomcat server
# add ami liunx
# selete instance type
#selete the private subnet id
#add  the tomcat sg id
#launch the key pair(ssh-keygen local)
# copy the key pair into pem file
#tag the name 


data "template_file" "userr_data_1" {
  template = "${file("tomcat_install.sh")}"
}

resource "aws_instance" "tomcat" {
  ami             = "ami-04db49c0fb2215364"
  instance_type   = "t2.medium"
  subnet_id       = aws_subnet.private-subnets[0].id
  security_groups = ["${aws_security_group.tomcat-security-group.id}", "${aws_security_group.bastion-security-roup.id}"]
  key_name        = "${aws_key_pair.tfm-key.id}"
  user_data       = file("tomcat_install.sh")
  tags = {
    Name = "tomcat"
  }
}













