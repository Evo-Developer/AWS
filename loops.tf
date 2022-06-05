terraform {
backend "s3" {
bucket = "pongal"
key = "terraform.tfstate"
region = "us-east-1"
}
}

variable "ami_name" {
    type=string
	default = "ami-0f9fc25dd2506cf6d"
}

variable "host_name" {
  default="WebServer"
}
 
 variable "servers" {
     type=list(string)
     default=["WebServer", "Application Server", "Database Server"]
 }

resource "aws_instance" "web1" {
  instance_type = "t3.micro"
  ami = var.ami_name
  key_name = aws_key_pair.deployer.key_name
  count =length(var.servers)
  tags = {
    Name = var.servers[count.index]
  }
 
}

output "webserver" {
    
    value=aws_instance.web1[0].public_ip
}


resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfOJIr8q33ATb7/Ad3DYaZJTHLb+P3DPgLMAAUXouXwIqNQTSgPOG67cm/vuAQ8RnestnbsFOz14ee7kCqZJae2YOKuz+mnVAddjeuj5GIe4IciDNlp8CyLSeHVIawOySj+2hRF+DypbTXOif7o2tegkUwdY3/POr429R/PGLqs1sS53Kp7ygXsPS9tHUNYWYUMqVgYkXB2N6nounNXDaZ+8zf3r7lOSySKpLa4XvqnkXFwyz8C5pqsC652jRKDUaVvu/Oew9+OaxjVi7ZyIJCA/WsQrzgXqHDZXapU4dtuWOpfPTEwjUtUT1/LBFC74SyCf1SsHQRNojp0ED0XIjn rsa-key-20220426"
}
