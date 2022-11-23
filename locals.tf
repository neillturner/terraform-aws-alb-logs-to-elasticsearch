locals {
  lambda_function_filename =  var.lambda_function_filename == "" ? "${path.module}/alb-logs-to-elasticsearch.zip" : var.lambda_function_filename
}
