data "aws_ami" "selected" {
  most_recent = true
  owners      = [var.ami_owner_id]

  filter {
    name   = "name"
    values = var.ami_name_filter
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ec2_instance" {
  for_each = {
    for idx, az in keys(var.subnet_ids) : az => {
      subnet_id = var.subnet_ids[az]
      name      = "${var.name}-${az}-${idx + 1}"
    }
  }

  ami           = data.aws_ami.selected.id
  instance_type = var.instance_type
  subnet_id     = each.value.subnet_id
  vpc_security_group_ids = var.security_group_id
  key_name      = local.generated_key_pair_name
  user_data     = var.user_data
  depends_on = [aws_key_pair.final_task_pair]
  tags = merge(
    var.common_tags, 
    var.instance_tags,
    {
      Name = each.value.name
    }
  )
  
}

locals {
      generated_key_pair_name = "${var.name_prefix}-key-pair"
}

resource "tls_private_key" "tls_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048  
}

resource "aws_key_pair" "final_task_pair" {
  key_name   = local.generated_key_pair_name 
  public_key = tls_private_key.tls_private_key.public_key_openssh
}

resource "local_file" "ssh_local_key" {
    content  = tls_private_key.tls_private_key.private_key_pem
    filename = "${path.module}/keys/${var.name_prefix}-key-pair.pem"
    file_permission = "0600"  
}
