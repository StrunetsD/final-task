resource "aws_s3_bucket" "s3_bucket_final_task" {
    force_destroy = false
    bucket        = var.name_of_s3_bucket

    tags = {
        Name        = var.name_of_s3_bucket
        Environment = var.environment["prod"]
    }
}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning_final_task" {
    bucket = aws_s3_bucket.s3_bucket_final_task.id

    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_bucket_public_access" {
    bucket                  = aws_s3_bucket.s3_bucket_final_task.id
    block_public_acls       = true
    ignore_public_acls      = true
}

resource "aws_dynamodb_table" "terraform_state_lock_table" {
    name           = var.terraform_state_lock_table
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }

    tags = {
        Name        = var.terraform_state_lock_table
        Environment = var.environment["prod"]
    }
  
}