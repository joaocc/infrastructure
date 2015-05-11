# The Deis VPC
resource "aws_vpc" "main" {
    enable_dns_support = true
    enable_dns_hostnames = true
    cidr_block = "10.21.0.0/16"

    tags {
        Name = "Deis"
    }
}
