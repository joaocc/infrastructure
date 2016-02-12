# Cluster Size
variable "counts" {
    default = {
      production_workers = 3
      feature_workers = 1
      routers = 3
      core = 5

      # Must update `var.subnet_azs` to match
      subnets = 3
    }
}

# Instance Settings
variable "instance_types" {
    default = {
      bastion = "t2.small"
      production_worker = "r3.xlarge"
      feature_worker = "r3.large"
      core = "r3.large"
      database = "db.r3.xlarge"
      redis = "cache.m3.large"
      router = "c3.large"
      proxy-gateway = "t2.small"
    }
}

variable "fleet_tags" {
  default = {
    core = "type=core,function=deis,controlPlane=true"
    production_worker = "type=worker,environment=production,function=deis,dataPlane=true"
    feature_worker = "type=worker,environment=feature,function=deis,dataPlane=true"
    bastion = "type=bastion"
    router = "type=router,function=deis,routerMesh=true"
    proxy-gateway = "type=proxy-gateway,function=proxy"
  }
}

# AMI Table
variable "amis" {
    default = {
      coreos_766_5_0 = "ami-37bdc15d" # Keep for the core machines
      coreos_835_12_0 = "ami-dfb699b5" # Latest core-os stable distribution
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
