# create jenkins server
# add ami liunx
# selete instance type
#selete the private subnet id
#add  the jenkins sg id
#launch the key pair(ssh-keygen local)
# copy the key pair into pem file
#tag the name 

data "template_file" "user_data_2" {
  template = "${file("install_jenkins.sh")}"
}

resource "aws_instance" "jenkins-stg" {
  ami             = "ami-04db49c0fb2215364"
  instance_type   = "t2.large"
  subnet_id       = aws_subnet.private-subnets[0].id
  security_groups = ["${aws_security_group.jenkins-security-group.id}", "${aws_security_group.bastion-security-roup.id}"]
  key_name        = "${aws_key_pair.tfm-key.id}"
  user_data       = file("install_jenkins.sh")
  tags = {
    Name = "jenkins-Stg"
  }
}


output "jenkins_endpoint" {
  value = formatlist("/var/lib/jenkins/secrets/initialAdminPassword")
}
