# ------ modules/networking/variables.tf

variable "instance_tenancy" {
  type        = string
  description = "tenancy for VPC, defualt(shared) or not shared"
}

variable "vpc_cidr" {}
variable "access_ip" {}
variable "private_sn_count" {}
variable "public_sn_count" {}
variable "public_cidrs" {

}
variable "private_cidrs" {

}

variable "vpc_instance_tenancy" {

}

variable "default_rt_route_cidr_block" {

}
variable "public_route_cidr_block" {

}
variable "elastic_ip_vpc" {

}
