output "state_bucket_name" {
  value       = aws_s3_bucket.tfstate.id
  description = "S3 bucket for Terraform state"
}

output "lock_table_name" {
  value       = aws_dynamodb_table.tflock.name
  description = "DynamoDB table for state locking"
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  value = var.aws_region
}
