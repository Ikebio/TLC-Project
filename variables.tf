variable "region" {
  default     = "eu-west-2"
}

# VPC
variable "vpc_name" {
  default     = "Proud-Tlc-VPC"
}

variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
}


# Public Subnet
variable "pub_sub1_cidr_block" {
  default     = "10.0.1.0/24"
}

variable "pub_sub1_name" {
  default     = "Test-public-sub1"
}

variable "pub_sub2_cidr_block" {
  default     = "10.0.2.0/24"
}

variable "pub_sub2_name" {
  default     = "Test-public-sub2"
}

# Privat Subnut
variable "priv_sub1_cidr_block" {
  default     = "10.0.3.0/24"
}

variable "priv_sub1_name" {
  default     = "Test-privat-sub1"
}

variable "priv_sub2_cidr_block" {
  default     = "10.0.4.0/24"
}

variable "priv_sub2_name" {
  default     = "Test-privat-sub2"
}

# Route Tabel
variable "pub_rout_name" {
  default     = "Test-pub-route-table"
}

variable "priv_rout_name" {
  default     = "Test-priv-route-table"
}