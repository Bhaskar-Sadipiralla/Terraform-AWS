#Create the Security Group for Bastion Server aka Jump Server
#Terraform AWS Security Groups

resource "aws_security_group" "bastion-security-roup" {
  name        = "Bastion Security Group"
  description = "Enable SSh access on port 22"
  vpc_id      = aws_vpc.terraform-vpc.id
  ingress {
    description = "bastion from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh-location}"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Bastion Security Group"
  }
}



#SecurityGroup name
resource "aws_security_group" "alb-security-group" {
  name        = "ALB Security Group"
  description = "Enable Http/Https access on port 80/443"
  vpc_id      = aws_vpc.terraform-vpc.id
  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS access"
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
    Name = "ALB Security Group"
  }
}


#Create Security Group for Jenkins Ec2


resource "aws_security_group" "jenkins-security-group" {
  name        = "Jenkins Security Group"
  description = "Enable Http/Https access on port 80/443 vis ALB and ssh access on 22 port vis Bastion"
  vpc_id      = aws_vpc.terraform-vpc.id
  ingress {
    description     = "HTTP access"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb-security-group.id}"]
  }

  ingress {
    description     = "SSH access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion-security-roup.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins Security Group"
  }
}


#Create RDS Security Group
resource "aws_security_group" "rds-security-group" {
  name        = "RDS Security Group"
  description = "Enable MySQL on port 3306 via Jenkins and worker node on port 3306"
  vpc_id      = aws_vpc.terraform-vpc.id
  ingress {
    description     = "MySQL Access "
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.jenkins-security-group.id}"]
  }
  ingress {
    description     = "MySQL Access to Worker Node"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion-security-roup.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}

resource "aws_security_group" "tomcat-security-group" {
  name        = "tomcat Security Group"
  description = "Enable Http/Https access on port 80/443 vis ALB and ssh access on 22 port vis Bastion"
  vpc_id      = aws_vpc.terraform-vpc.id
  ingress {
    description     = "HTTP access"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb-security-group.id}"]
  }

  ingress {
    description     = "SSH access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion-security-roup.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tomcat Security Group"
  }
}





resource "aws_security_group" "apache2-security-group" {
  name        = "apache2-security-group"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.terraform-vpc.id

  ingress {
    # SSH Port 22 allowed from any IP
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
      # SSH Port 80 allowed from any IP
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}










