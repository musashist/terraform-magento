module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "magento-test"

  engine            = "mysql"
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  allocated_storage = 5

  db_name  = var.rds_database_name
  username = var.rds_database_user
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [module.rds_security_group.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = var.rds_monitoring_role
  create_monitoring_role = true

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

    # options = [
    #   {
    #     option_name = "MARIADB_AUDIT_PLUGIN"

    #     option_settings = [
    #       {
    #         name  = "SERVER_AUDIT_EVENTS"
    #         value = "CONNECT"
    #       },
    #       {
    #         name  = "SERVER_AUDIT_FILE_ROTATIONS"
    #         value = "37"
    #       },
    #     ]
    #   },
    # ]
    
  tags = {
    Name = "Test Magento" 
    Environment = "dev"
  }
}