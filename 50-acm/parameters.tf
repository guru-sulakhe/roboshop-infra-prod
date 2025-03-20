resource "aws_ssm_parameter" "https_certificate_arn" {
    name = "/${var.project_name}/${var.environment}/https_certificate_arn"
    type = "String"
    values = aws_acm_certificate.roboshop.arn
}