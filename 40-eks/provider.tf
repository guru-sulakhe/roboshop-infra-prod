terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws" 
            version = "5.91.0" 
        }
    }
    backend "s3" {
        bucket = "guru97s-remote-state"
        key = "roboshop-infra-dev-eks"
        region = "us-east-1"
        dynamodb_tables = "guru97s-locking-dynamodb"
    }
}

provider "aws" {
    region = "us-east-1"
}