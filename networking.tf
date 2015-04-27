########################
####### Subnets ########
########################

# Availability Zone 1
resource "aws_subnet" "subnet" {
  count = "${lookup(var.counts, "subnets")}"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.21.${count.index + 1}.0/24"
    availability_zone = "us-east-1${lookup(var.subnet_azs, "subnet${count.index}")}"

    tags {
        Name = "subnet ${count.index}"
    }
}

########################
##### Route Tables #####
########################

# Primary route table
resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.public.id}"
    }

    tags {
        Name = "Public"
        Network = "Public"
    }
}

# Route table association for subnets
resource "aws_route_table_association" "route_table_association" {
    count = 3
    subnet_id = "${element(aws_subnet.subnet.*.id, count.index)}"
    route_table_id = "${aws_route_table.public.id}"
}

#########################
### Internet Gateways ###
#########################

# Primary Internet Gateway
resource "aws_internet_gateway" "public" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "Public"
        Network = "Public"
    }
}
