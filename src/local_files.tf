resource "local_sensitive_file" "private_key_pem" {
  content  = tls_private_key.neon_key.private_key_pem
  filename = "${path.module}/neon_key.pem"
}
