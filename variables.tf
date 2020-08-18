variable "create" {
  description = "Bool to create"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the resources"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

