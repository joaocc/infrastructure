# Cluster Size
variable "counts" {
    default = {
      workers = 6
      core = 3
    }
}

variable "deis_version" {
    default = "1.5.2"
}

# Instance Settings
variable "instance_types" {
    default = {
      bastion = "t2.micro"
      worker = "r3.xlarge"
      core = "m3.large"
    }
}

# AMI Table
variable "amis" {
    default = {
      coreos = "ami-323b195a"
      ubuntu = "ami-6889d200"
    }
}

# Subnets
variable "subnet_azs" {
    default = {
      subnet0 = "a"
      subnet1 = "c"
      subnet2 = "d"
      subnet3 = "e"
    }
}