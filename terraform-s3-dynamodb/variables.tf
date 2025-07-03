variable "region" {
    description = "AWS region to deploy resources"
    type        = string
    default     = "eu-north-1"  
}

variable "owner" {
    description = "Owner of the resources"
    type        = string
    default     = "dstrunetss"  
}

variable "environment" {
  description = "value of the environment tag"
  type        = map(string)
    default     = {
        prod = "Production",
        dev  = "Development",
        test = "Testing"
    }
}

variable "name_of_s3_bucket" {
    description = "Name of the S3 bucket"
    type        = string
    default     = "s3-bucket-final-task-state"
}

variable "terraform_state_lock_table" {
    description = "Name of the DynamoDB table for Terraform state locking"
    type        = string
    default     = "terraform_state_lock_table"
}