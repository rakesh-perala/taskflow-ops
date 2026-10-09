output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value     = module.eks.cluster_endpoint
  sensitive = true
}

output "cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "ecr_backend_url" {
  value = module.eks.ecr_backend_url
}

output "ecr_frontend_url" {
  value = module.eks.ecr_frontend_url
}
output "github_actions_role_arn" {
  value       = module.github_oidc.role_arn
  description = "IAM role ARN for GitHub Actions"
}
