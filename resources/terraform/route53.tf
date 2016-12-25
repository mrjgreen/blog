resource "aws_route53_zone" "joeg" {
  name = "joeg.uk"
  comment = "Managed by Terraform at github.com/mrjgreen/blog"
  tags {
    Application = "Blog"
    Owner = "Joe Green"
    Provisioner = "Terraform"
    ProvisionerSrc = "github.com/mrjgreen/blog"
  }
}

resource "aws_route53_record" "blog" {
  zone_id = "${aws_route53_zone.joeg.zone_id}"
  name = "joeg.uk"
  type = "A"

  alias {
    name = "${aws_s3_bucket.blog.website_domain}"
    zone_id = "${aws_s3_bucket.blog.hosted_zone_id}"
    evaluate_target_health = false
  }
}