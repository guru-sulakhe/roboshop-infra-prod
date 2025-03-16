variable "project_name" {
    default = "roboshop"
}
variable "environment" {
    default = "prod"
}
variable "common_tags" {
    default = {
        Project = "roboshop"
        Terraform = true
        Environment = "prod"
    }
}
variable "bastion_tags" {
    default = {
        Component = "bastion"
    }
}