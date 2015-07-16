# Brandfolder Infrastructure

This is the configuration for the Brandfolder infrastructure. 

| Powered By Deis | Managed With Terraform | Provided By AWS |
|:-------------:|:-------------:|:-----:|
| [![Deis](https://brandfolder.com/brandfolder-infrastructure/assets/yf0vtwt0)](http://deis.io) | [![Terraform](https://brandfolder.com/brandfolder-infrastructure/assets/ak6pnrtw)](https://terraform.io) | [![AWS](https://brandfolder.com/brandfolder-infrastructure/assets/a70ln6en)](https://aws.amazon.com)

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

## Infrastructure Map

View the [infrastructure map](map.asci).
