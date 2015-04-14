# Availability Zone 1
resource "aws_subnet" "az-us-east-1a" {
    vpc_id = "${aws_vpc.paas.id}"
    cidr_block = "10.21.1.0/24"
    availability_zone = "us-east-1a"

    tags {
        Name = "az-us-east-1a"
    }
}

# Availability Zone 2
resource "aws_subnet" "az-us-east-1c" {
    vpc_id = "${aws_vpc.paas.id}"
    cidr_block = "10.21.2.0/24"
    availability_zone = "us-east-1c"

    tags {
        Name = "az-us-east-1c"
    }
}

# Primary route table
resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.paas.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.public.id}"
    }

    tags {
        Name = "Public"
        Network = "Public"
    }
}

# Route table association for subnet 1
resource "aws_route_table_association" "az-us-east-1a" {
    subnet_id = "${aws_subnet.az-us-east-1a.id}"
    route_table_id = "${aws_route_table.public.id}"
}

# Route table association for subnet 2
resource "aws_route_table_association" "az-us-east-1c" {
    subnet_id = "${aws_subnet.az-us-east-1c.id}"
    route_table_id = "${aws_route_table.public.id}"
}

# Primary Internet Gateway
resource "aws_internet_gateway" "public" {
    vpc_id = "${aws_vpc.paas.id}"

    tags {
        Name = "Public"
        Network = "Public"
    }
}
