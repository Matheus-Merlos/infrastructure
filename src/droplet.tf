resource "tls_private_key" "neon_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "digitalocean_ssh_key" "neon_ssh_key" {
  name       = "Neon Instance Key"
  public_key = tls_private_key.neon_key.public_key_openssh
}

resource "digitalocean_droplet" "neon_droplet" {
  name = "neon-droplet"

  image    = "debian-12-x64"
  size     = "s-1vcpu-512mb-10gb"
  region   = "nyc1"
  ssh_keys = [ digitalocean_ssh_key.neon_ssh_key.id ]
}
