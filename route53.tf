# # get hosted zone details
# data "aws_route53_zone" "boss-hosted-zone" {
#   name = var.domain_name
# }

# # create a record set in route 53
# resource "aws_route53_record" "boss-site-domain" {
#   zone_id = data.aws_route53_zone.boss-hosted-zone.zone_id
#   name    = var.alternative_name
#   type    = "A"

#   alias {
#     name                   = aws_lb.boss-application-load-balancer.dns_name
#     zone_id                = aws_lb.boss-application-load-balancer.zone_id
#     evaluate_target_health = true
#   }
# }