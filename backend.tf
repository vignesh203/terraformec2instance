terraform {
  backend "s3" {
    bucket = "terrasecnew"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}