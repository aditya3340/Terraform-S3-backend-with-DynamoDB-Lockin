resource "aws_vpc" "myVpc" {
  cidr_block = var.cidr_block_range
}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myVpc.id
  cidr_block              = var.cidr_block_range_sub1
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name : "public-subnet-01"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id                  = aws_vpc.myVpc.id
  cidr_block              = var.cidr_block_range_sub2
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name : "public-subnet-02"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myVpc.id
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  route_table_id = aws_route_table.RT.id
  subnet_id      = aws_subnet.sub1.id
}

resource "aws_route_table_association" "rta2" {
  route_table_id = aws_route_table.RT.id
  subnet_id      = aws_subnet.sub2.id
}

resource "aws_security_group" "websg" {
  name        = "websg"
  description = "Allow SSH and TCP Traffic"
  vpc_id      = aws_vpc.myVpc.id

  ingress {
    description = "Allow HTTP connection"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  ingress {
    description = "Allow SSH connection"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  egress {
    description = "outbound rule"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
  }

  tags = {
    Name = "allow_tls"
  }
}



resource "aws_s3_bucket" "my-bucket" {
  bucket = var.bucket_name
  tags = {
    Name : var.bucket_name
    Enviroment : "dev"
  }
}

resource "aws_instance" "instance1" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.sub1.id
  security_groups = [aws_security_group.websg.id]
  key_name        = var.key_name
  user_data       = base64encode(file(var.userdata))
}

resource "aws_instance" "instance2" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.sub2.id
  security_groups = [aws_security_group.websg.id]
  key_name        = var.key_name
  user_data       = base64encode(file(var.userdata1))
}

resource "aws_lb" "mylb" {
  name = "myalb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.websg.id]
  subnets = [aws_subnet.sub1.id, aws_subnet.sub2.id]

  tags = {
    Name = "web"
  }
}

resource "aws_lb_target_group" "myTG" {
  name = "myTG"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.myVpc.id

  health_check {
    path = "/"
    port = "traffic-port"  
  }  
}

resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.myTG.arn
  target_id = aws_instance.instance1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.myTG.arn
  target_id = aws_instance.instance2.id
  port = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.mylb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.myTG.arn
    type = "forward"
  }
}

output "loadbalancerdns" {
  value = aws_lb.mylb.dns_name
}


