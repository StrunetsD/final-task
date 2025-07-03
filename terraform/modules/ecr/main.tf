resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  dynamic "encryption_configuration" {
    for_each = var.enable_encryption ? [1] : []
    content {
      encryption_type = var.encryption_type
      kms_key         = var.kms_key_arn
    }
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "this" {
  count      = var.create_repository_policy ? 1 : 0
  repository = aws_ecr_repository.this.name
  policy     = var.repository_policy
}

resource "aws_ecr_lifecycle_policy" "this" {
  count      = var.create_lifecycle_policy ? 1 : 0
  repository = aws_ecr_repository.this.name
  policy     = var.lifecycle_policy
}

