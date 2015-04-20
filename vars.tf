# Keys (required)
variable "aws_access_key" {}
variable "aws_secret_key" {}

# Cluster Size
variable "cluster_size" {
    default = 5
}

# Region
variable "aws_region" {
    default = "us-east-1"
}

variable "deis_version" {
    default = "1.5.1"
}

# Instance Settings
variable "aws_instance_type" {
    default = "r3.xlarge"
}

# AMI Table
variable "aws_coreos_amis" {
    default = {
      eu-west-1 = "ami-55950a22"
      eu-central-1 = "ami-0e300d13"
      ap-northeast-1 = "ami-af28dcaf"
      ap-southeast-1 = "ami-f80b3aaa"
      ap-southeast-2 = "ami-b9b5c583"
      sa-east-1 = "ami-2354ec3e"
      us-east-1 = "ami-323b195a"
      us-west-1 = "ami-8dd533c9"
      us-west-2 = "ami-0789a437"
    }
}

variable "aws_ubuntu_amis" {
    default = {
      eu-west-1 = "ami-edfd6e9a"
      eu-central-1 = "ami-e6a694fb"
      ap-northeast-1 = "ami-8f876e8f"
      ap-southeast-1 = "ami-62546230"
      ap-southeast-2 = "ami-c94e3ff3"
      sa-east-1 = "ami-a757eeba"
      us-east-1 = "ami-6889d200"
      us-west-1 = "ami-c37d9987"
      us-west-2 = "ami-35143705"
    }
}
