resource "aws_lb" "alb-stg" {
  name               = "alb-stg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-security-group.id]
  subnets            = ["${aws_subnet.public-subnets[0].id}", "${aws_subnet.public-subnets[1].id}"]

  enable_deletion_protection = true


  tags = {
    Environment = "dev"
  }
}


# instance target group

resource "aws_lb_target_group" "testalb-stg-tg" {
  name     = "alb-stg-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform-vpc.id
}



resource "aws_lb_target_group_attachment" "alb-stg" {
  target_group_arn = aws_lb_target_group.testalb-stg-tg.arn
  target_id        = aws_instance.tomcat.id
  port             = 8080
}





# listner


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb-stg.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.testalb-stg-tg.arn
  }
}


# instance target group







