module "alb" {
  source = "terraform-aws-modules/alb/aws"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
  enable_deletion_protection = false

  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "10.0.0.0/16"
    }
  }

 access_logs = {
   bucket = "magento-s3-bucket-for-logs"
 }

  listeners = {
    http = {
        port = 80
        protocol = "HTTP"
        forward = {
          target_group_key = "ex-instance"
        }
    }
  }

  target_groups = {
    ex-instance = {
      name_prefix      = "mg-tst"
      protocol         = "HTTP"
      port             = 80
      target_type      = "instance"
      create_attachment = false
      targets = {
        for i, server in values(module.app_instance)[*].id :
        i => {
          target_id = server
          port      = 80
        }
      } 
    }
  }

  tags = {
    Name = "Magento Test Internal"
    Environment = "test"
  }
}


resource "aws_lb_target_group_attachment" "tg_attachment_one" {
 target_group_arn = module.alb.target_groups["ex-instance"].arn
 target_id        = module.app_instance["one"].id
 port             = 80
}



resource "aws_lb_target_group_attachment" "tg_attachment_two" {
 target_group_arn = module.alb.target_groups["ex-instance"].arn
 target_id        = module.app_instance["two"].id
 port             = 80
}



resource "aws_lb_target_group_attachment" "tg_attachment_three" {
 target_group_arn = module.alb.target_groups["ex-instance"].arn
 target_id        = module.app_instance["three"].id
 port             = 80
}