resource "aws_vpc" "main_vpc" {
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "us_east_1a_public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.us_east_1a_subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "us-east-1a-subnet"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
}
