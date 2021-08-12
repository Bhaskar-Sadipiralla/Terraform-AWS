resource "aws_route53_zone" "venkatcloud_aws" {
  name = "venkatcloud.xyz"

  tags = {
    Environment = "dev"
  }
}



resource "aws_route53_record" "apache2" {
  zone_id = aws_route53_zone.venkatcloud_aws.zone_id
  name    = "apache2.venkatcloud.xyz"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.eip.public_ip]
}

