# Cluster Size
variable "counts" {
    default = {
      production_workers = 5
      feature_workers = 5
      core = 5

      # Must update `var.subnet_azs` to match
      subnets = 3
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

variable "fleet_tags" {
  default = {
    core = "type=core"
    production_worker = "type=worker,environment=production"
    feature_worker = "type=worker,environment=feature"
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
    }
}