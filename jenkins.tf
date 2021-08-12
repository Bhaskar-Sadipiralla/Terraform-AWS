# create jenkins server
# add ami liunx
# selete instance type
#selete the private subnet id
#add  the jenkins sg id
#launch the key pair(ssh-keygen local)
# copy the key pair into pem file
#tag the name 

data "template_file" "user_data" {
  template = "${file("install_jenkins.sh")}"
}

resource "aws_instance" "jenkins" {
  ami             = "ami-00bf4ae5a7909786c"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private-subnet-1.id
  security_groups = ["${aws_security_group.jenkins-security-group.id}", "${aws_security_group.bastion-security-roup.id}"]
  key_name        = "${aws_key_pair.petclinic.id}"
  user_data       = file("install_jenkins.sh")
  tags = {
    Name = "jenkins"
  }
}


output "jenkins_endpoint" {
  value = formatlist("/var/lib/jenkins/secrets/initialAdminPassword")
}
