output "cluster_name" {
  value       = aws_eks_cluster.main.name
  description = "EKS cluster name"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.main.endpoint
  description = "EKS cluster endpoint"
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.main.certificate_authority[0].data
  description = "EKS cluster CA data"
}

output "cluster_oidc_issuer_url" {
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
  description = "OIDC issuer URL for IRSA"
}

output "oidc_provider_arn" {
  value       = aws_iam_openid_connect_provider.cluster.arn
  description = "OIDC provider ARN for IRSA"
}

output "node_role_arn" {
  value       = aws_iam_role.node.arn
  description = "Node IAM role ARN"
}

output "ecr_backend_url" {
  value       = aws_ecr_repository.backend.repository_url
  description = "ECR URL for backend image"
}

output "ecr_frontend_url" {
  value       = aws_ecr_repository.frontend.repository_url
  description = "ECR URL for frontend image"
}
