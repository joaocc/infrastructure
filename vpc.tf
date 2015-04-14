# The Deis VPC
resource "aws_vpc" "paas" {
    enable_dns_support = true
    enable_dns_hostnames = true
    cidr_block = "10.21.0.0/16"

    tags {
        Name = "Platform-as-a-Service"
    }
}