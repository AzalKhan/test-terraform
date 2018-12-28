variable "AWS_REGION_NAME" {
  type = "string"
}

#======================================================================
variable "VPC_CIDR" {
  description = "CIDR for the VPC"
  type = "string"
}

variable "INSTANCE_TENANCY" {
  description = "A tenancy option for instances launched into the VPC"
  type = "string"
}
#=======================================================================

variable PUBLIC_SUBNET_CIDR  {
  type = "string"
}
variable AVAILABILITY_ZONE {
  type = "string"
}

variable SUBNET_ID {
  type = "string"
}

#=======================================================================
variable "INSTANCE_TYPE" {
  type = "string"
}

variable "AMI_IMAGE" {
  type = "string"
}

variable "KEYPAIR" {
  type = "string"
}

variable "VPC_SECURITY_GROUP_IDS" {
  type = "list"
}

#========================================================================

variable  "BUCKET_NAME" {
  type = "string"
}

variable "NETWORK_ACL" {
type = "string"

}