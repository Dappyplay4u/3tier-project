variable "boss-vpc-cidr" {
  default = "11.0.0.0/16"
  type = string
}

variable "boss-publicsubnet1-cidr" {
  default = "11.0.0.0/24"
  type = string
}

variable "boss-publicsubnet2-cidr" {
  default = "11.0.1.0/24"
  type = string
}

variable "boss-privatesubnet1-cidr" {
  default = "11.0.2.0/24"
  type = string
}

variable "boss-privatesubnet2-cidr" {
  default = "11.0.3.0/24"
  type = string
}

variable "boss-privatesubnet3-cidr" {
  default = "11.0.4.0/24"
  type = string
}

variable "boss-privatesubnet4-cidr" {
  default = "11.0.5.0/24"
  type = string
}

variable "ssh-location" {
  default = "0.0.0.0/0"
  type    = string
}

variable "domain_name" {
  default = "florenceapartments.link"
  type    = string
}

variable "alternative_name" {
  default = "florenceapartments1.link"
  type    = string
}