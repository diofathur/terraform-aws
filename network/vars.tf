variable "cidr" {
  default = "10.212.222.0/24"
}

# Variable for CIDR Subnet public, private, staging
variable "subnet" {
  type    = list(any)
  default = ["10.212.222.0/26", "10.212.222.64/26"]
}

# Variable for Availability Zone
variable "az" {
  type    = list(any)
  default = ["ap-southeast-3a", "ap-southeast-3b"]
}