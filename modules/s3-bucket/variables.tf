variable "bucket_name" {
  type        = string
  description = "Name of the S3 Bucket"
}

variable "acl" {
  type        = string
  description = "The Bucket ACL, can be private, public-read, public-read-write, etc."
  validation {
    condition     = contains(["public-read", "private", "public-read-write", "bucket-owner-read", "bucket-owner-full-control"], var.acl)
    error_message = "Invalid acl value"
  }
}