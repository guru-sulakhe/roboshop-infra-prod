module "mysql_sg" {
    source = "git::https://github.com/guru-sulakhe/terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    sg_name = "mysql_sg"
    vpc_id = local.vpc_id
    sg_tags = var.mysql_sg_tags
    sg_description = "mysql inbound rule"
}

module "node_sg" {
    source = "git::https://github.com/guru-sulakhe/terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    sg_name = "node_sg"
    vpc_id = local.vpc_id
    sg_description = "node inbound rule"
}

module "eks_control_plane_sg" {
    source = "git::https://github.com/guru-sulakhe/terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    sg_name = "eks_control_plane_sg"
    vpc_id = local.vpc_id
    sg_description = "eks_control_plane ingress sg"
}

module "bastion" {
    source = "git::https://github.com/guru-sulakhe/terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    sg_name = "bastion_sg"
    vpc_id = local.vpc_id
    sg_description = "bastion inbound rule"
}

module "ingress_alb_sg" {
    source = "git::https://github.com/guru-sulakhe/terraform-aws-securitygroup.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    sg_name = "ingress_alg_sg"
    vpc_id = local.vpc_id
    sg_description = "ingress_alb inbound rule"
}

resource "aws_security_group_rule" "ingress_alb_https" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.ingress_alb_sg
}

resource "aws_security_group_rule" "node_ingress_alb" {
    type = "ingress"
    from_port = 30000
    to_port = 32767
    protocol = "tcp"
    source_security_group_id = module.ingress_alb_sg
    security_group_id = module.node_sg
}

resource "aws_security_group_rule" "node_eks_control_plane" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    source_security_group_id = module.eks_control_plane_sg.id
    security_group_id = module.node_sg.id
}

resource "aws_security_group_rule" "node_vpc" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.0.0.0/16"]
    security_group_id = module.node_sg
}

resource "aws_security_group_rule" "node_bastion" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    source_security_group_id = module.bastion_sg
    security_group_id = module.node_sg
}

resource "aws_security_group_rule" "eks_control_plane_node" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    source_security_group_id = module.node_sg
    security_group_id = module.eks_control_plane_sg
}

resource "aws_security_group_rule" "eks_control_plane_bastion" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    source_security_group_id = module.bastion_sg
    security_group_id = module.eks_control_plane_sg
}

resource "aws_security_group_rule" "mysql_bastion" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    source_security_group_id = module.bastion_sg
    security_group_id = module.mysql_sg
}

resource "aws_security_group_rule" "mysql_node"{
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    source_security_group_id = module.node_sg
    security_group_id = module.mysql_sg
}

resource "aws_security_group_rule" "bastion_public" {
    type = "ingress"
    from_port  = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.bastion_sg
}