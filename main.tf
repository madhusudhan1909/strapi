provider "aws" {
  region = "ap-southeast-1"
}

data "aws_instance" "existing_instance" {
  instance_id = "i-071170ba4826f6150"  // Specify the existing instance ID
}

resource "null_resource" "provision_commands" {
  depends_on = [data.aws_instance.existing_instance]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y npm",
      "sudo npm install pm2 -g",
      "npm install",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAkzi/XpLoAtyIiN31mKPllTUVtC4fJja/5au/n4rOo45WuyOU
PITWJUgIj7bDR1lUEasvwoUoPWld+9LtD6KPg4ePZm8sXn8yXtVO5Hdf/hJCrSFT
nOZFTmK31hB3dKUe3T8wwdQfEH5C5tG78xpZSgTM6B9i1Y9dJ4/5qylTXWesyjo5
B2saTakPBkS1Lb+M66huVLIGBJqI9vmBeMJfgxl8mucTq57efVmDsltrMCLGKLVI
IGArLjCog4pnVuFYU+iEQ5CpKwus2qunUTd3oEe9jCr7bi7Xk5OBu6jI5mdHY1XP
wpY82NUKmZne0/F2Z/9fOVVTGKh1G+nzrCRKNQIDAQABAoIBAGkvWktP2sRwnHxt
WVO9hgKc8uzRJyA+bczCcR6kJg9lW0JJoVe78OSiGrvTcKJBiHc3P+BTEvUNm0CY
6xcIplDrQeGF/MVnS63F6aACSmtU0J6x+PNY8puWnJItIawNbYfV5hgWXjuCeno/
z3FZmgHwfBY8lnjO/VeO3msUE6PfoIohRZp8KU3uE/JhB/dze3qZ9pzIApSBkzAq
kP0LGUnBIuMQ5GRSGvKUkOL0d6ApF8qo3shnEDdZNqANXUYIY7qgojfxuxLSH5Y3
gQXLB8vVOlr7YAgqdyKMG/4tC2+yx2Jzhnq5NqyKlchceuZ4/ikX0U5kKrsoYnli
vOfGueECgYEA0xjgjCJS1bjdRjKQZeN/6S0NGkE5CZpDzYZXp//RwYWvkBP4MAj1
C0pTcqGFyPK2pjp6L8s3D9pB/V83HzqOFzwPmsqWkObGRowB1k0HGqR+ypZ9zMSq
D+Mdr3196OYnWK193u9PR1OJfvM31sYxMiq/pYhQE4nCL2UE4CxxL38CgYEAsomV
EsjUilUSoVQuG6HsyIn1uo/IxJ/aCT2lTGsvCm8p6NSBEL6qAQLqDiNOd+tz9EJh
LuUHCAEVkBrP80iZ4cVgeV5GZsuzNpZEkQrFb7WwVZaaGI4UxSs3PWOaDIAmcCWf
Yc+PpPeThqXNTbZtnqKDmBEKLz9dxza2l3y0oEsCgYEAwWABmv16SkQNl1eMhXmQ
3AakARAMcup5ABX3yHMFMDUJrX9NlJsv9obAyLqENp94h+/7rDqJFyGF39fQQ/A8
57XiSZcZtGVi7o8kw65OOq7DY0vWs7TYYLNZpz/bDnV/R7GuI4GvaxRwWPXuifWG
bYFRjA7B5BQG6amtfLnZeXsCgYA7mb5QNQbu3xOHE8kIpHedQqDrlNBbA1oQN6oU
5rsfapi9ByPG6T9rcwObkKHDWrCs2/QBaad9Po9qOektuBDW08MvAQ/ThTDgii19
lfDvJ+Ij0FDE3bmFULXyImvsvGMYkRax2k6Drbpr+rGcvce+a1Yuz5Fs0GSH+nXe
AF10HQKBgGJcwWcgiH6w05rc9JuKV/gfyGXdks1VHA5a+wdarWk1ZXEKfbzoXU8O
OyF/vHhkBGxgIrFLY+1++nlABvyAUKFqIGOViWYKEqMzzeQLBu9jwudogSsKPuIR
Y+br4elCD5uu/uyQhXokjBX6Ry048RNC77q2+JnyQysHrNrVZ/Kc
-----END RSA PRIVATE KEY-----
EOF
    host        = "13.229.80.114"  // Update with your existing instance's public IP
  }
}
}

output "instance_public_ip" {
  value = "13.229.80.114"
}

output "instance_private_ip" {
  value = "172.31.20.95"
}
