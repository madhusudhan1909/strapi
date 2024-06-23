provider "aws" {
  region = "ap-southeast-1"
}

data "aws_instance" "existing_instance" {
  instance_id = "i-071170ba4826f6150"
}

resource "null_resource" "provision_commands" {
  depends_on = [data.aws_instance.existing_instance]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y npm",
      "sudo npm install pm2 -g"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = data.aws_instance.existing_instance.public_ip
    }
  }
}

output "instance_public_ip" {
  value = data.aws_instance.existing_instance.public_ip
}

output "instance_private_ip" {
  value = data.aws_instance.existing_instance.private_ip
}
