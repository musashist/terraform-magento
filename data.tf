data "aws_ami" "magento_ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Ubuntu owner

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]  # Ubuntu 20.04
  }
}
