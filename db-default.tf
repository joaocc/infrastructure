# Primary Database instance
resource "aws_db_instance" "default" {
    identifier = "postgres"

    # Instance Config
    instance_class = "db.r3.xlarge"

    # Storage
    allocated_storage = 100
    iops = 1000

    # Engine
    engine = "postgres"
    engine_version = "9.4.1"

    # Network
    multi_az = true
    port = 5432
    publicly_accessible = false
    db_subnet_group_name = "${aws_db_subnet_group.default.name}"
    vpc_security_group_ids = ["${aws_security_group.rds.id}"]

    # DB Config
    username = "${file("private/db/pguser")}"
    password = "${file("private/db/pgpass")}"

    # AWS config
    backup_window = "05:00-08:30"
    maintenance_window = "sat:09:30-sat:22:00"
    backup_retention_period = 30

}

# Subnet Group
resource "aws_db_subnet_group" "default" {
    name = "main"
    description = "VPC Subnet groups"
    subnet_ids = ["${aws_subnet.az-us-east-1a.id}",
                  "${aws_subnet.az-us-east-1c.id}"]
}