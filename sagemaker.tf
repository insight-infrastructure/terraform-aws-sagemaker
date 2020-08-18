data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

variable "sagemaker_notebook_name" {}

variable "subnet_id" {
  description = ""
  type        = string
  default     = null
}

variable "vpc_id" {
  description = ""
  type        = string
  default     = null
}

resource "aws_sagemaker_notebook_instance" "this" {
  name          = var.sagemaker_notebook_name
  role_arn      = aws_iam_role.this.arn
  instance_type = "ml.t2.medium"

  lifecycle_config_name = aws_sagemaker_notebook_instance_lifecycle_configuration.this.name

  subnet_id = var.subnet_id
}

data "template_file" "cloud_init" {
  template = file("${path.module}/templates/sagemaker_instance_init.sh")

  vars = {
    notebook_bucket_name = var.notebook_bucket_name
    scripts_bucket_name  = var.scripts_bucket_name
  }
}

resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "this" {
  name     = var.sagemaker_notebook_name
  on_start = base64encode(data.template_file.cloud_init.rendered)
}

//resource "aws_sagemaker_model" "this" {
//  name               = "terraform-sagemaker-example"
//  execution_role_arn = aws_iam_role.this.arn
//
//  primary_container {
//    image          = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/foo:latest"
//    model_data_url = "https://s3-us-west-2.amazonaws.com/${aws_s3_bucket.notebook.bucket}/model.tar.gz"
//  }
//
//  tags = var.tags
//}

//resource "aws_sagemaker_endpoint_configuration" "foo" {
//  name = "terraform-sagemaker-example"
//
//  production_variants {
//    variant_name           = "variant-1"
//    model_name             = aws_sagemaker_model.this.name
//    initial_instance_count = 1
//    instance_type          = "ml.t2.medium"
//    initial_variant_weight = 1
//  }
//
//  tags = var.tags
//}
//
//resource "aws_sagemaker_endpoint" "this" {
//  name                 = "terraform-sagemaker-example"
//  endpoint_config_name = aws_sagemaker_endpoint_configuration.foo.name
//
//  tags = var.tags
//}

