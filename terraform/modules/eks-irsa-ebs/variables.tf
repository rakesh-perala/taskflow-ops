variable "project_name"      { type = string }
variable "environment"       { type = string }
variable "cluster_name"      { type = string }
variable "oidc_provider_arn" { type = string }
variable "oidc_issuer_url"   { type = string }

variable "tags" {
  type    = map(string)
  default = {}
}
