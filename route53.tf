# resource "aws_route53_zone" "venkatcloud_aws" {
#   name = "evschargingstation.com"

#   tags = {
#     Environment = "dev"
#   }
# }



# resource "aws_route53_record" "stage" {
#   zone_id = aws_route53_zone.venkatcloud_aws.zone_id
#   name    = "stage.evschargingstation.com"
#   type    = "A"
#   ttl     = "300"
#   records = [aws_eip.eip.public_ip]
# }

