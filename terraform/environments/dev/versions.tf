terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
# ---------- GitHub OIDC ----------
module "github_oidc" {
  source = "../../modules/github-oidc"

  project_name = var.project_name
  environment  = var.environment
  github_org   = "rakesh-perala"
  github_repo  = "taskflow-app"
  tags         = local.common_tags
}

# ---------- EBS CSI with IRSA ----------
module "eks_irsa_ebs" {
  source = "../../modules/eks-irsa-ebs"

  project_name      = var.project_name
  environment       = var.environment
  cluster_name      = module.eks.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_issuer_url   = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
  tags              = local.common_tags
}

# ---------- Kubernetes + Helm Providers ----------
data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

# ---------- ArgoCD ----------
module "argocd" {
  source = "../../modules/argocd"

  project_name     = var.project_name
  environment      = var.environment
  cluster_endpoint = module.eks.cluster_endpoint
  cluster_ca_data  = module.eks.cluster_certificate_authority_data
  cluster_name     = module.eks.cluster_name
  github_org       = "rakesh-perala"
  github_repo      = "taskflow-ops"

  depends_on = [module.eks]
}
