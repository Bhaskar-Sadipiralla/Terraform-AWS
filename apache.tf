
resource "aws_instance" "apache" {
ami = "ami-00bf4ae5a7909786c"
instance_type = "t2.micro" 
subnet_id = aws_subnet.public-subnet-1.id
security_groups = ["${aws_security_group.apache2-security-group.id}"]
key_name = "${aws_key_pair.petclinic.id}"
tags = {
    Name = "apache"
  }
} 




resource "aws_eip" "eip" {
  instance = aws_instance.apache.id
  vpc      = true
}


data "template_file" "userrr_data" {
  template = "${file("install_apache2.sh")}"
}