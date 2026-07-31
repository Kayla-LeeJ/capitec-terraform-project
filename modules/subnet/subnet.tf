#--------------------------------#
# Module: subnet
#--------------------------------#

#Resource: aws_subnet
resource "aws_subnet" "az" {
  for_each                = { for i, az in var.availability_zones : az => i }
  vpc_id                  = var.vpc_id
  cidr_block              = local.subnet_allocation[var.lookup_key].subnets[each.value]
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(local.default_tags, {
    Name = "${var.prefix}-az${each.value + 1}-subnet-${var.environment}"
  })
  lifecycle {
    ignore_changes = [tags]
  }
}

#Resource: aws_route_table_association
resource "aws_route_table_association" "rt-association" {
  for_each       = aws_subnet.az
  subnet_id      = each.value.id
  route_table_id = var.rt_id
}
