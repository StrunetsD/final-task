variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
    default     = ""
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
    default     = "main_vpc"
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

variable "name_prefix_sg" {
  description = "Prefix for security group, usually in format project-environment."
  type        = string
  
}

variable "public_subnet_new_bits" {
  description = "Number of new bits to add to the VPC CIDR block for public subnets"
  type        = number
  default     = 8
}

variable "azs" {
  description = "values for availability zones"
  type        = list(string)
}

variable "destination_cidr_block" {
  description = "Destination CIDR block for the route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "name_prefix" {
  description = "A prefix for naming all resources created by this VPC module."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources created by the module."
  type        = map(string)
    default     = {}
}