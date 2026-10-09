output "role_arn" {
  value       = aws_iam_role.github_actions.arn
  description = "IAM role ARN for GitHub Actions OIDC"
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.github.arn
}
