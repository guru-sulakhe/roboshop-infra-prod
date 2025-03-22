variable "project_name" {
    default = "roboshop"
}
variable "environment" {
    default = "prod"
}
variable "common_tags" {
    default = {
        Project = "roboshop"
        Environment = "prod"
        Terraform = true
    }
}
variable "ingress_alb_tags" {
    default = {
        Component = "web-alb"
    }
}
variable "zone_name" {
    default = "guru97s.cloud"
}