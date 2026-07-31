# module "kayla-s3" {
#   source      = "/Module"
#   initials    = var.initials
#   surname     = var.surname
#   resource    = var.resource
#   environment = var.environment
# }

module "kayla-subnet" {
  source        = "./modules/subnet"
  initials      = var.initials
  surname       = var.surname
  environment   = var.environment
  lookup_key    = "kayla_lee_jansma"
}

module "kayla-eks" {
  source        = "./modules/eks"
  capacity_type = var.capacity_type
  initials      = var.initials
  surname       = var.surname
  environment   = var.environment
  subnet_ids    = module.kayla-subnet.subnet_ids
  depends_on    = [module.kayla-subnet]
}