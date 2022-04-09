resource "aws_lambda_function" "alb_logs_to_elasticsearch_vpc" {
  count            = length(var.subnet_ids) > 0 ? 1 : 0
  filename         = "${path.module}/alb-logs-to-elasticsearch.zip"
  function_name    = "${var.prefix}alb-logs-to-elasticsearch"
  description      = "${var.prefix}alb-logs-to-elasticsearch"
  timeout          = 300
  runtime          = "nodejs${var.nodejs_version}"
  role             = aws_iam_role.role.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256("${path.module}/alb-logs-to-elasticsearch.zip")

  environment {
    variables = {
      es_endpoint = var.es_endpoint
      index       = var.index
      doctype     = var.doctype
      region      = var.region
    }
  }

  tags = merge(
    var.tags,
    tomap({ "Scope" = "${var.prefix}lambda_function_to_elasticsearch" }),
  )

  # This will be a code block with empty lists if we don't create a securitygroup and the subnet_ids are empty.
  # When these lists are empty it will deploy the lambda without VPC support.
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.lambda[0].id]
  }
}

resource "aws_lambda_permission" "allow_terraform_bucket_vpc" {
  count         = length(var.subnet_ids) > 0 ? 1 : 0
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.alb_logs_to_elasticsearch_vpc[0].arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_bucket_arn
}

resource "aws_lambda_function" "alb_logs_to_elasticsearch" {
  count            = length(var.subnet_ids) == 0 ? 1 : 0
  filename         = "${path.module}/alb-logs-to-elasticsearch.zip"
  function_name    = "${var.prefix}alb-logs-to-elasticsearch"
  description      = "${var.prefix}alb-logs-to-elasticsearch"
  timeout          = 300
  runtime          = "nodejs${var.nodejs_version}"
  role             = aws_iam_role.role.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256("${path.module}/alb-logs-to-elasticsearch.zip")


  environment {
    variables = {
      es_endpoint = var.es_endpoint
      index       = var.index
      doctype     = var.doctype
      region      = var.region
    }
  }

  tags = merge(
    var.tags,
    tomap({ "Scope" = "${var.prefix}lambda_function_to_elasticsearch" }),
  )
}

resource "aws_lambda_permission" "allow_terraform_bucket" {
  count         = length(var.subnet_ids) == 0 ? 1 : 0
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.alb_logs_to_elasticsearch[0].arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_bucket_arn
}
