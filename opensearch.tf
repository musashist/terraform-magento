module "opensearch" {
  source = "terraform-aws-modules/opensearch/aws"

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  advanced_security_options = {
    enabled                        = false
    anonymous_auth_enabled         = true
    internal_user_database_enabled = true

    # Consider using Secret Manager instead
    master_user_options = {
      master_user_name     = "root" 
      master_user_password = var.opensearch_master_user_password
    }
  }

  auto_tune_options = {
    desired_state = "ENABLED"

    maintenance_schedule = [
      {
        start_at                       = "2024-05-13T07:44:12Z"
        cron_expression_for_recurrence = "cron(0 0 ? * 1 *)"
        duration = {
          value = "2"
          unit  = "HOURS"
        }
      }
    ]

    rollback_on_disable = "NO_ROLLBACK"
  }

  cluster_config = {
    instance_count           = 2
    dedicated_master_enabled = true
    dedicated_master_type    = var.opensearch_instance_type
    instance_type            = var.opensearch_instance_type

    zone_awareness_config = {
      availability_zone_count = 2
    }

    zone_awareness_enabled = true
  }

  domain_endpoint_options = {
    enforce_https       = false
    #tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  domain_name = var.opensearch-domain-name

  ebs_options = {
    ebs_enabled = true
    iops        = 100
    throughput  = 125
    volume_type = "gp2"
    volume_size = 20
  }

  encrypt_at_rest = {
    enabled = false
  }

  engine_version = var.opensearch_engine_version

  log_publishing_options = [
    { log_type = "INDEX_SLOW_LOGS" },
    { log_type = "SEARCH_SLOW_LOGS" },
  ]

  node_to_node_encryption = {
    enabled = true
  }

  software_update_options = {
    auto_software_update_enabled = true
  }

  vpc_options = {
    subnet_ids = module.vpc.private_subnets
  }


  # vpc_endpoints = {
  #   one = {
  #     subnet_ids = module.vpc.private_subnets
  #   }
  # }

  access_policy_statements = [
    {
      effect = "Allow"

      principals = [{
        type        = "*"
        identifiers = ["*"]
      }]

      actions = ["es:*"]

      condition = [{
        test     = "IpAddress"
        variable = "aws:SourceIp"
        values   = ["127.0.0.1/32",module.vpc.vpc_cidr_block]
      }]
    }
  ]

  tags = {
    Name   = "Magento Test"
    Environment = "test"
  }
}