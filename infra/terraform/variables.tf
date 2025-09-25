variable "region" {
  default = "ap-south-1"
}

variable "db_username" {
  default = "postgres"
}

variable "db_password" {
  description = "RDS password"
  sensitive   = true
}

variable "cluster_name" {
  default = "cloud-native-cluster"
}


