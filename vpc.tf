resource "aws_vpc" "terraform-vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.envname}"
  }
}

#create Internet Gateway and attach to Public Subnet
#Terraform Aws InternetGateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "${var.envname}-IGW"
  }
}

# Create Public Subnet 
#Public Subnets using terraform
resource "aws_subnet" "public-subnets" {
  count = length(var.azs)
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = element(var.public-subnets, count.index)
  availability_zone       = element(var.azs,count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.envname}-pubsubnet-${count.index+1}"
  }
}

#Create Private Subnet 
#Private Subnets using terraform
resource "aws_subnet" "private-subnets" {
  count = length(var.azs)
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = element(var.private-subnets, count.index)
  availability_zone       = element(var.azs,count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.envname}-private-subnets-${count.index+1}"
  }
}

#Create Data Subnet 
#Data Subnets using terraform
resource "aws_subnet" "data-subnets" {
  count = length(var.azs)
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = element(var.data-subnets, count.index)
  availability_zone       = element(var.azs,count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.envname}-data-subnet-${count.index+1}"
  }
}
#EIP
resource "aws_eip" "natIp" {
    vpc      = true
  tags = {
    Name = "${var.envname}-natIp"
  }
}
# Create Nat Gateway
resource "aws_nat_gateway" "NatGw" {
  allocation_id = aws_eip.natIp.id
  subnet_id     = aws_subnet.public-subnets[0].id

  tags = {
    Name = "${var.envname}-natGW"
  }
}

# Create a Public Route Table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "${var.envname}-publicroute"
  }
}
# Create a Private Route Table Association

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NatGw.id
  }

  tags = {
    Name = "${var.envname}-privateroute"
  }
}

resource "aws_route_table" "date-route-table" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NatGw.id
  }

  tags = {
    Name = "${var.envname}-dataroute"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
resource "aws_route_table_association" "pubrouteassociation" {
  count = length(var.public-subnets)
  subnet_id      = element(aws_subnet.public-subnets.*.id,count.index)
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "privaterouteassociation" {
  count = length(var.private-subnets)
  subnet_id      = element(aws_subnet.private-subnets.*.id,count.index)
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "datarouteassociation" {
  count = length(var.private-subnets)
  subnet_id      = element(aws_subnet.data-subnets.*.id,count.index)
  route_table_id = aws_route_table.date-route-table.id
}