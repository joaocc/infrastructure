# Cluster Size
variable "counts" {
    default = {
      production_workers = 3
      feature_workers = 1
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
      production_worker = "r3.xlarge"
      feature_worker = "r3.large"
      core = "r3.large"
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
      coreos = "ami-d2033bba"
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