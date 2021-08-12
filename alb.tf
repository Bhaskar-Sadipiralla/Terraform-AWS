resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-security-group.id]
  subnets            = ["${aws_subnet.public-subnet-1.id}", "${aws_subnet.public-subnet-2.id}"]

  enable_deletion_protection = true


  tags = {
    Environment = "dev"
  }
}


# instance target group

resource "aws_lb_target_group" "test" {
  name     = "test-lb-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform-vpc.id
}



resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.tomcat.id
  port             = 8080
}





# listner


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}


# instance target group







