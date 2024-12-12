module "varnish_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.varnish_sg_name
  description = "Varnish server security group"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
}


module "app_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = var.app_sg_name
  description = "Magento app servers security groups"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["10.10.0.0/16"]
}


module "rds_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.rds_sg_name
  description = "RDS server security group"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 3306
      protocol    = "tcp"
      description = "Mysql"
      cidr_blocks = "10.10.0.0/16"
    },
  ]
}
