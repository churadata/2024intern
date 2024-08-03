resource "aws_s3_bucket" "state_bucket" {
  bucket = "2024-intern-${local.name}"
}
