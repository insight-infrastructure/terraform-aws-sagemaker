variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

module "defaults" {
  source = "../.."

  notebook_paths = [
    "${path.module}/notebooks/Scikit-learn_Estimator_Example_With_Terraform.ipynb"
  ]
  scripts_paths = [
    "${path.module}/scriptss/scikit_learn_script.py"
  ]
}
