# module "kayla-s3" {
#   source      = "/Module"
#   initials    = var.initials
#   surname     = var.surname
#   resource    = var.resource
#   environment = var.environment
# }

module "kayla-eks" {
  source        = "./modules/eks"
  capacity_type = var.capacity_type
  initials      = var.initials
  surname       = var.surname
  environment   = var.environment
}