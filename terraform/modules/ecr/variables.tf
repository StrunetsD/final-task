variable "repository_name" {
  description = "The name of the ECR repository."
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE."
  type        = string
  default     = "MUTABLE"
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "Image tag mutability must be either 'MUTABLE' or 'IMMUTABLE'."
  }
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository."
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Set to true to enable encryption for the repository."
  type        = bool
  default     = false
}

variable "encryption_type" {
  description = "The encryption type to use for the repository. Valid values are AES256 or KMS."
  type        = string
  default     = "AES256"
  validation {
    condition     = contains(["AES256", "KMS"], var.encryption_type)
    error_message = "Encryption type must be either 'AES256' or 'KMS'."
  }
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use when encryption_type is KMS. If not specified, uses the default AWS managed key for ECR."
  type        = string
  default     = null
}

variable "create_repository_policy" {
  description = "Set to true to create a repository policy."
  type        = bool
  default     = false
}

variable "repository_policy" {
  description = "The JSON policy document for the ECR repository."
  type        = string
  default     = "{}" 
}

variable "create_lifecycle_policy" {
  description = "Set to true to create a lifecycle policy for the repository."
  type        = bool
  default     = false
}

variable "lifecycle_policy" {
  description = "The JSON policy document for the ECR lifecycle policy."
  type        = string
  default     = "{}" 
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}