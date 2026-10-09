terraform {
  backend "s3" {
    bucket         = "taskflow-tfstate-dev-652310866649"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "taskflow-tflock-dev"
    encrypt        = true
  }
}
