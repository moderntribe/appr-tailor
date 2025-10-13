resource "aws_route53_record" "platform_alias_record" {
  zone_id = "Z0779292D32CEPGAT7T2"  # advancingpretrial.org (public hosted zone)
  name    = "tailor-${var.environment}.advancingpretrial.org"
  type    = "A"

  alias {
    name                   = aws_lb.tailor_lb.dns_name
    zone_id                = aws_lb.tailor_lb.zone_id
    evaluate_target_health = true
  }
}
