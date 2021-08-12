variable "ssh-location" {
  default     = "0.0.0.0/0"
  description = "Ip address that can SSH into Bastion"
  type        = string
}




variable "vpc-cidr" {
  default = "10.0.0.0/16"
  type    = string
}
variable "public-subnet-1-cidr" {
  default = "10.0.0.0/24"
  type    = string
}
variable "public-subnet-2-cidr" {
  default = "10.0.1.0/24"
  type    = string
}
variable "private-subnet-1-cidr" {
  default = "10.0.2.0/24"
  type    = string
}
variable "private-subnet-2-cidr" {
  default = "10.0.3.0/24"
  type    = string
}
variable "private-subnet-3-cidr" {
  default = "10.0.4.0/24"
  type    = string
}
variable "private-subnet-4-cidr" {
  default = "10.0.5.0/24"
  type    = string
}