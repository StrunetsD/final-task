resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_cidr_block

    tags = merge(var.tags, {
        Name = var.vpc_name
    })
}

resource "aws_subnet" "public_subnets" {
  for_each = toset(var.azs)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, var.public_subnet_new_bits, index(var.azs, each.key))
  availability_zone = each.key
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-public-${each.key}"
  })
}

resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-igw" 
  })
}
resource "aws_route_table_association" "public_subnet_associations" {
  for_each       = aws_subnet.public_subnets 
  subnet_id      = each.value.id
  route_table_id = aws_route_table.main_route_table.id 
}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.destination_cidr_block
    gateway_id = aws_internet_gateway.main_gateway.id
  }
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-rt"
  })
}

resource "aws_security_group" "security_group" {
  name        = "${var.name_prefix_sg}-sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  dynamic "ingress" {
    for_each = [
      { port = 22, protocol = "tcp", description = "SSH access" },
      { port = 80, protocol = "tcp", description = "HTTP access" }, 
      { port = -1, protocol = "icmp", description = "Ping access" }
    ]
    
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
      tags = {
        Name = "${var.name_prefix_sg}-sg"
    }
}