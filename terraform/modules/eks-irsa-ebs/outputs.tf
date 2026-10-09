output "role_arn"   { value = aws_iam_role.ebs_csi.arn }
output "addon_name" { value = aws_eks_addon.ebs_csi.addon_name }
