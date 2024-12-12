resource "random_shuffle" "subnet_selection" {
  input = module.vpc.private_subnets  # Get all subnet IDs
  result_count = 1                       # Get one random subnet
}

module "app_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["one", "two", "three"])

  ami                    = data.aws_ami.magento_ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.ssh_key
  monitoring             = false
  vpc_security_group_ids = [module.app_security_group.security_group_id]
  subnet_id              = random_shuffle.subnet_selection.result[0]

  tags = {
    Name = "Magento App"
    Environment = "test"
  }
}

module "varnish_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  ami                    = data.aws_ami.magento_ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.ssh_key
  monitoring             = false
  vpc_security_group_ids = [module.varnish_security_group.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Name = "Magento Varnish"
    Environment = "test"
  }
}


