variable "cidr" {
  default = "192.168.150.0/24"
}

# Variable for CIDR Subnet public, private, staging
variable "subnet" {
  type    = list(any)
  default = ["192.168.150.0/26", "192.168.150.64/26", "192.168.150.128/26"]
}

# Variable for Availability Zone
variable "az" {
  type    = list(any)
  default = ["ap-southeast-3a", "ap-southeast-3b"]
}

