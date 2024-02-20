variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0cf10cdf9fcd62d37"
    us-east-2 = "ami-0cf7b2f456cd5efd4"
  }
}