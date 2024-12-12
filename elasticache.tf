module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"

  cluster_id               = var.elasticache_cluster_id
  create_cluster           = true
  create_replication_group = false

  engine_version = var.elasticache_engine_version
  node_type      = var.elasticache_node_type

  maintenance_window = "sun:05:00-sun:09:00"
  apply_immediately  = true

  vpc_id = module.vpc.vpc_id
  security_group_rules = {
    ingress_vpc = {
      description = "VPC traffic"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  subnet_ids = module.vpc.private_subnets

  create_parameter_group = true
  parameter_group_family = "redis7"
  parameters = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  tags = {
    Name = "Magento Test"
    Environment = "test"
  }
}