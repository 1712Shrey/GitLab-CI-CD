module "ec2" {
  source = "./modules/ec2"
  i-name = var.i-name
  cnt = var.cnt
  public-subnet-id = module.vpc.public-subnet-id
  sg-id = module.vpc.sg-id
  ami-id = var.ami-id
  type = var.type
}