# Brandfolder Infrastructure

This is the configuration for the Brandfolder infrastructure. 

| Powered By Deis (PaaS) | Managed With Terraform (IaC) | Provided By AWS (IaaS) |
|:-------------:|:-------------:|:-----:|
| [![Deis](https://brandfolder.com/brandfolder-infrastructure/assets/yf0vtwt0)](http://deis.io) | [![Terraform](https://brandfolder.com/brandfolder-infrastructure/assets/ak6pnrtw)](https://terraform.io) | [![AWS](https://brandfolder.com/brandfolder-infrastructure/assets/a70ln6en)](https://aws.amazon.com)

## Infrastructure Map

View the [infrastructure map](map.asci).

## Security Model

### Cluster Access

#### SSH Access

SSH Access to the cluster is only provided via a [Bastion Host](https://en.wikipedia.org/wiki/Bastion_host). The bastion host only exposes port 22 for SSH an requires a public-key belonging to the "bastion" team in github. Once within the bastion host, users have full access to rest of the cluster.

The "bastion-master" key, that provides root access to the bastion machine is under lock and key and only accessible by the CTO of Brandfolder.

#### Security Patches

see [System Updates](#system-updates)

## Clustering

There are 3 primary components of Brandfolder. Each of which is designed to scale (or not to scale) indepedently.

### The Core

The core is comprised of exactly and always 5 [Core OS](https://coreos.com/) machines. The core runs the PaaS controller, the App Builder and the App Registry as Services. The core is the MOST STABLE piece of the platform. It's primary function is to keep consensus of at least 3 machines in order provide [etcd](https://github.com/coreos/etcd) as a key-value store for cluster wide configuration.

### System Updates

All of the machines automatically update to the stable channel of [Core OS](https://coreos.com/). This is a core feature of the operating system and offers Brandfolder no-touch up-to-date patches for security and new features.

### Networking

## Auto Scaling

**TODO**

## PaaS

## Developing on Brandfolder's Infrastructure

**Prerequisites:**

* Install Terraform
* Sign up for [Atlas](https://atlas.hashicorp.com/) and get invited to the Brandfolder organization.
* Find your Atlas API access key, you will need it next.
* Run the following command:
  `terraform remote config -backend-config="access_token={{Atlas Access Key}}" -backend-config="name=brandfolder/infrastructure"`
* (Optional) Set your environment variables to include
  ```
  export AWS_ACCESS_KEY_ID={{Your AWS Access Key}}
  export AWS_SECRET_ACCESS_KEY={{Your AWS Secret Access Key}}
  ```

**Usage:**

1. Make the changes in project.
1. View Planned Changes
  `make plan`
1. Commit the Changes
  `git add -a`
  `git commit -m "commit message`
1. Apply the Changes
  `make apply`
