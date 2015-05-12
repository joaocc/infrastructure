# Infrastructure

This is the configuration for the Brandfolder infrastructure. Built and managed
with [Terraform](github.com/hashicorp/terraform).

## Prerequisites

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

## Usage

### Viewing changes

`make plan'`

### Applying changes

`make apply`

## Workflow

1. Make changes to terraform files
2. Run `make plan` to view changes and check for errors
3. Commit changes
4. Run `make apply`
