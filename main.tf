provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "strapi_instance" {
  ami                    = "ami-003c463c8207b4dfa"  // Update with your Ubuntu 20.04 AMI ID
  instance_type          = "t2.medium"
  subnet_id              = "subnet-0ba5354c77b6d001f"  // Update with your subnet ID
  key_name               = "TASK2"  // Replace with your key pair name
  vpc_security_group_ids = ["sg-0795d88eba4e1b125"]  // Update with your security group ID

  tags = {
    Name = "srv-strapi"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y npm",
      "sudo npm install pm2 -g",
      "git clone -b madhu https://github.com/madhusudhan1909/strapi.git /home/ubuntu/strapi",  // Clone your repository to /home/ubuntu/strapi
      "cd /home/ubuntu/strapi/examples/getstarted",  // Navigate to the getstarted directory
      "npm install",  // Install dependencies
      "pm2 start npm --name 'strapi' -- start"  // Start Strapi application using PM2
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/ubuntu/TASK2.pem")  // Update with correct path to your .pem file
      host        = "13.229.80.114"
    }
  }
}

output "instance_public_ip" {
  value = aws_instance.strapi_instance.public_ip
}

output "instance_private_ip" {
  value = aws_instance.strapi_instance.private_ip
}
