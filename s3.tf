// Resources
// https://github.com/yuyasugano/terraform-sagemaker-sample-1/blob/master/modules/s3/main.tf
// https://github.com/jckuester/terraform-sagemaker-example/blob/master/main.tf

variable "notebook_bucket_name" {
  description = ""
  type        = string
  default     = ""
}

variable "scripts_bucket_name" {
  description = ""
  type        = string
  default     = ""
}

locals {
  notebook_bucket_name = var.notebook_bucket_name == "" ? "sagemaker-notebooks-${data.aws_caller_identity.current.account_id}" : var.notebook_bucket_name
  scripts_bucket_name  = var.scripts_bucket_name == "" ? "sagemaker-scripts-${data.aws_caller_identity.current.account_id}" : var.scripts_bucket_name
}

resource "aws_s3_bucket" "notebook" {
  bucket        = local.notebook_bucket_name
  force_destroy = true
  acl           = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "sagemaker" {
  bucket        = local.scripts_bucket_name
  force_destroy = true
  acl           = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

variable "notebook_paths" {
  description = ""
  type        = list(string)
  default     = []
}
variable "notebook_key_prefix" {
  description = ""
  type        = string
  default     = "notebooks"
}

resource "aws_s3_bucket_object" "notebook" {
  count  = length(var.notebook_paths)
  bucket = aws_s3_bucket.notebook.id
  key    = "${var.notebook_key_prefix}/${var.notebook_paths[count.index]}"
  source = var.notebook_paths[count.index]
  etag   = filemd5(var.notebook_paths[count.index])
}

variable "script_paths" {
  description = ""
  type        = list(string)
  default     = []
}

variable "script_key_prefix" {
  description = ""
  type        = string
  default     = "scripts"
}

resource "aws_s3_bucket_object" "script" {
  count  = length(var.script_paths)
  bucket = aws_s3_bucket.notebook.id
  key    = "${var.script_key_prefix}/${var.script_paths[count.index]}"
  source = var.script_paths[count.index]
  etag   = filemd5(var.script_paths[count.index])
}