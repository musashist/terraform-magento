# EC2

variable "instance_type" {
 default = "t3.micro"
 description = "EC2 instance type"
}

# Elasticache

variable "elasticache_cluster_id" {
 default = "magento-test"
 description = "Redis cluster id"
}

variable "elasticache_engine_version" {
 default = "7.1"
 description = "Redis cluster id"
}

variable "elasticache_node_type" {
 default = "cache.t2.micro"
 description = "Redis node type"
}

# Opensearch

variable "opensearch_instance_type" {
 default = "t2.small.search"
 description = "EC2 instance type"
}

variable "opensearch_master_user_password" {
  sensitive = true
  default   = "toor"
}

variable "opensearch-domain-name" {
  default   = "magento-test-opensearch"
  description = "name of opensearch domain"
}

variable "opensearch_engine_version" {
  default   = "OpenSearch_2.11"
  description = "opensearch engine version"
}

# RDS

variable "rds_instance_class" {
  default   = "db.t3.micro"
  description = "rds instance class"
}

variable "rds_engine_version" {
  default   = "8.0"
  description = "mysql engine version"
}

variable "rds_database_name" {
  default   = "magento"
  description = "rds database name"
}

variable "rds_database_user" {
  default   = "user"
  description = "rds mysql user"
}

variable "rds_monitoring_role" {
  default   = "MagentoRDSMonitoringRole"
  description = "rds monitoring IAM role"
}

# S3

variable "s3_name" {
  default = "magento_logs"
  description = "name of s3 for logs"
}

# Security Group

variable "varnish_sg_name" {
  default = "varnish_ec2_test"
  description = "Name of security group for varnish instance"
}

variable "app_sg_name" {
  default = "app_ec2_test"
  description = "Name of security group for app instances"
}

variable "rds_sg_name" {
  default = "rds_test"
  description = "Name of security group for RDS"
}

# Misc

variable "region" {
  default     = "eu-central-1"
  description = "AWS region"
}

variable "ssh_key" {
  default     = "user1"
  description = "ssh key for instance access"
}

