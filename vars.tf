# Variable for AWS_Region
# variable "AWS_REGION" {
#   default = "ap-southeast-1"
# }

# Variable for CIDR VPC
variable "cidr" {
  default = "10.11.0.0/16"
}

# Variable for CIDR Subnet public, private, staging
variable "subnet" {
  type    = list(any)
  default = ["10.11.11.0/24", "10.11.12.0/24", "10.11.13.0/24"]
}

# Variable for Availability Zone
variable "az" {
  type    = list(any)
  default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}
