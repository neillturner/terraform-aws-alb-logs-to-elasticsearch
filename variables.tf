variable "doctype" {
  description = "doctype"
  default     = "alb-access-logs"
}

variable "es_endpoint" {
  description = "AWS elasticsearch endpoint. Without http:// or https:// "
}

variable "index" {
  description = "Index to create. adds a timestamp to index. Example: alblogs-2016.03.31"
  default     = "alblogs"
}

variable "nodejs_version" {
  description = "Nodejs version to be used"
  default     = "8.10"
}

variable "prefix" {
  description = "A prefix for the resource names, this helps create multiple instances of this stack for different environments"
  default     = ""
}

variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "s3_bucket_arn" {
  description = "The arn of the s3 bucket containing the alb logs"
}

variable "s3_bucket_id" {
  description = "The id of the s3 bucket containing the alb logs"
}

variable "subnet_ids" {
  description = "Subnet IDs you want to deploy the lambda in. Only fill this in if you want to deploy your Lambda function inside a VPC."
  type        = "list"
  default     = []
}

variable "tags" {
  description = "Tags to apply"

  default = {
    Name = "alb-logs-to-es"
  }
}
