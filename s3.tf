module "s3_logs" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.s3_name
  acl    = "log-delivery-write"
  force_destroy = true

  control_object_ownership = true
  object_ownership = "ObjectWriter"

  attach_elb_log_delivery_policy = true
  attach_lb_log_delivery_policy  = true 
  
}