variable "name" {
  description = "A unique name for the EC2 instance(s). Will be used as a base for resource names."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instance(s) will be launched."
  type        = string
  
}

variable "instance_type" {
  description = "The EC2 instance type (e.g., t3.micro)."
  type        = string
}

variable "ami_owner_id" {
  description = "The AWS account ID of the AMI owner (e.g., 'amazon' for Amazon AMIs, or your account ID)."
  type        = string
  default     = "amazon"
}

variable "virtualization-type" {
  description = "The virtualization type of the AMI (e.g., hvm)."
  type        = string
  default     = "hvm"
  
}

variable "ami_name_filter" {
  description = "A list of name filters for the AMI search (e.g., ['al2023-ami-*-kernel-6.1-x86_64'])."
  type        = list(string)
  default     = ["al2023-ami-*-kernel-6.1-x86_64"]
}


variable "subnet_ids" {
  description = "Map of public subnet IDs per AZ"
  type        = map(string)
}

variable "instance_count_per_az" {
  description = "Number of instances to create per Availability Zone"
  type        = number
  default     = 1
}

variable "security_group_id" {
  description = "A list of security group IDs to attach to the EC2 instance(s). These should be created in your VPC/Networking module."
  type        = list(string)
}


variable "user_data" {
  description = "User data to provide when launching the EC2 instance. Can be a script."
  type        = string
  default     = null
}

variable "instance_tags" {
  description = "Additional tags to apply specifically to the EC2 instance(s)."
  type        = map(string)
  default     = {}
}

variable "common_tags" {
  description = "A map of common tags to apply to all resources. Typically inherited from higher Terragrunt levels."
  type        = map(string)
  default     = {}
}

variable "name_prefix_sg" {
  description = "Prefix for sg, usually in format project-environment."
  type        = string
}

variable "name_prefix" {
  description = "A prefix for naming all resources created by this EC2 module."
  type        = string
}