terraform {
  backend "s3" {
    key    = "eks"
    region = "us-east-1"
  }
}
