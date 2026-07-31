module "kayla-s3" {
  source      = "./modules/s3"
  prefix      = var.prefix
  initials    = var.initials
  surname     = var.surname
  resource    = var.resource
  environment = var.environment
}

module "kayla-subnet" {
  source      = "./modules/subnet"
  prefix      = var.prefix
  initials    = var.initials
  surname     = var.surname
  environment = var.environment
  lookup_key  = "kayla_lee_jansma"
  vpc_id      = var.vpc_id
  rt_id       = var.rt_id
}

module "kayla-eks" {
  source        = "./modules/eks"
  prefix        = var.prefix
  capacity_type = var.capacity_type
  initials      = var.initials
  surname       = var.surname
  environment   = var.environment
  subnet_ids    = module.kayla-subnet.subnet_ids
  depends_on    = [module.kayla-subnet]
}
