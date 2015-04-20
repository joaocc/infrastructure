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
      eu-west-1 = "ami-b53252c2"
      eu-central-1 = "ami-56eed24b"
      ap-northeast-1 = "ami-aa57adaa"
      ap-southeast-1 = "ami-9a8bb9c8"
      ap-southeast-2 = "ami-e70974dd"
      sa-east-1 = "ami-2b890c36"
      us-east-1 = "ami-fe724896"
      us-west-1 = "ami-3500e271"
      us-west-2 = "ami-45d5ff75"
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
