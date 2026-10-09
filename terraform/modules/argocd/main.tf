locals {
  argocd_namespace = "argocd"
}

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = local.argocd_namespace
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "6.7.11"
  timeout          = 600

  values = [yamlencode({
    server = {
      service = {
        type = "ClusterIP"
      }
    }
    configs = {
      params = {
        "server.insecure" = true
      }
    }
  })]
}

# Note: ArgoCD Application manifests (argocd/applications/*.yaml)
# are applied AFTER terraform apply completes, using kubectl.
# See project README for post-apply steps.
