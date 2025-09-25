output "eks_cluster_name" {
  value = var.cluster_name
}

output "rds_endpoint" {
  value = aws_db_instance.cloudnative.address
}

output "db_name" {
  value = aws_db_instance.cloudnative.db_name
}
