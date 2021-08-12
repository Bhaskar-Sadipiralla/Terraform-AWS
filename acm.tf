# resource "aws_acm_certificate" "venkat" {
#   domain_name       = "venkatcloud.xyz"
#   validation_method = "EMAIL"
# }

# resource "aws_acm_certificate_validation" "venkat" {
#   certificate_arn = aws_acm_certificate.venkat.arn
# }