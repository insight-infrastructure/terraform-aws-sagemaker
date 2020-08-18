# terraform-aws-sagemaker

[![open-issues](https://img.shields.io/github/issues-raw/insight-infrastructure/terraform-aws-sagemaker?style=for-the-badge)](https://github.com/insight-infrastructure/terraform-aws-sagemaker/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-infrastructure/terraform-aws-sagemaker?style=for-the-badge)](https://github.com/insight-infrastructure/terraform-aws-sagemaker/pulls)

## Features

This module sets up a Sagemaker cluster on AWS.

> WIP - Not ready for prime time

## Terraform Versions

For Terraform v0.12.0+

## Usage

```hcl-terraform
module "this" {
  source = "github.com/insight-infrastructure/terraform-aws-sagemaker"
}
```
## Examples

- [defaults](https://github.com/insight-infrastructure/terraform-aws-sagemaker/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| create | Bool to create | `bool` | `true` | no |
| ingress\_tcp\_public | List of tcp ports for public ingress | `list(string)` | <pre>[<br>  22<br>]</pre> | no |
| ingress\_udp\_public | List of udp ports for public ingress | `list(string)` | <pre>[<br>  22<br>]</pre> | no |
| name | The name of the resources | `string` | n/a | yes |
| notebook\_bucket\_name | n/a | `string` | `""` | no |
| notebook\_key\_prefix | n/a | `string` | `"notebooks"` | no |
| notebook\_paths | n/a | `list(string)` | `[]` | no |
| sagemaker\_notebook\_name | n/a | `any` | n/a | yes |
| script\_key\_prefix | n/a | `string` | `"scripts"` | no |
| script\_paths | n/a | `list(string)` | `[]` | no |
| scripts\_bucket\_name | n/a | `string` | `""` | no |
| subnet\_id | n/a | `string` | n/a | yes |
| tags | Tags for resources | `map(string)` | `{}` | no |
| vpc\_id | n/a | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [insight-infrastructure](https://github.com/insight-infrastructure)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.