variable "doctype" {
  type        = string
  description = "doctype"
  default     = "alb-access-logs"
}

variable "es_endpoint" {
  type        = string
  description = "AWS elasticsearch endpoint. Without http:// or https:// "
}

variable "index" {
  type        = string
  description = "Index to create. adds a timestamp to index. Example: alblogs-2016.03.31"
  default     = "alblogs"
}

variable "lambda_function_filename" {
  type        = string
  description = "Filename with the lambda's source code"
  default     = ""
}

variable "nodejs_version" {
  type        = string
  description = "Nodejs version to be used"
  default     = "14.x"
}

variable "prefix" {
  type        = string
  description = "A prefix for the resource names, this helps create multiple instances of this stack for different environments"
  default     = ""
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "s3_bucket_arn" {
  type        = string
  description = "The arn of the s3 bucket containing the alb logs"
}

variable "s3_bucket_id" {
  type        = string
  description = "The id of the s3 bucket containing the alb logs"
}

variable "subnet_ids" {
  description = "Subnet IDs you want to deploy the lambda in. Only fill this in if you want to deploy your Lambda function inside a VPC."
  type        = list(string)
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default = {
    Name = "alb-logs-to-es"
  }
}
