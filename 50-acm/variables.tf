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
variable "zone_name" {
    default = "guru97s.cloud"
}
variable "zone_id" {
    default = "Z08273698E2G6XTP9T7C"
}