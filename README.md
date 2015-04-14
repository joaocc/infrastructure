# Infrastructure

This is the configuration for the Brandfolder infrastructure. Built and managed
with [Terraform](github.com/hashicorp/terraform).

***Note:*** **Pending several PR's you must use the brandfolder fork of terraform**
```
$ git clone git@github.com/brandfolder/terraform
$ make updatedeps
$ make dev
```

## Prerequisites

* Install Terraform
* Sign up for [Atlas](https://atlas.io) and get invited to the Brandfolder organization.
* Find your Atlas API access key, you will need it next.
* Run the following command:
  `terraform remote config -backend-config="access_token={{Atlas Access Key}}" -backend-config="name=brandfolder/infrastructure"`

## Usage

### Viewing changes

`terraform plan -var 'aws_access_key={{your AWS access key}}' -var 'aws_secret_key={{your AWS secret key}}'`

### Applying changes

`terraform apply -var 'aws_access_key={{your AWS access key}}' -var 'aws_secret_key={{your AWS secret key}}'`

## Workflow

1. Make changes to terraform files
2. Run plan to view changes and check for errors
3. Commit changes
4. Run apply
