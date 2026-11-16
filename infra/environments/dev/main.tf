# Configuración principal de Terraform para el entorno de desarrollo
# Incluye módulos y recursos necesarios para desplegar la infraestructura

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.100"
    }
  }
}

# Módulo para DynamoDB
module "dynamodb_orders" {
  source = "../../modules/dynamodb"

  table_name               = var.dynamodb_table_name
  billing_mode             = var.dynamodb_billing_mode
  hash_key                 = var.dynamodb_hash_key
  range_key                = var.dynamodb_range_key
  global_secondary_indexes = var.dynamodb_global_secondary_indexes
  attributes               = var.dynamodb_attributes
  ttl_attribute            = var.dynamodb_ttl_attribute
  ttl_enabled              = var.dynamodb_ttl_enabled
  stream_enabled           = var.dynamodb_stream_enabled
  stream_view_type         = var.dynamodb_stream_view_type
  read_capacity            = var.dynamodb_read_capacity
  write_capacity           = var.dynamodb_write_capacity
  point_in_time_recovery   = var.dynamodb_point_in_time_recovery_enabled
  backup_enabled           = var.dynamodb_backup_enabled
  tags                     = merge(var.tags, { Name = var.dynamodb_table_name })
}

# Outputs del módulo DynamoDB

# Configuración de políticas IAM para acceso a DynamoDB
resource "aws_iam_policy" "dynamodb_access_policy" {
  name        = "${var.project}-dynamodb-access-policy-${var.environment}"
  description = "Política para acceso a la tabla DynamoDB de órdenes"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchWriteItem",
          "dynamodb:BatchGetItem"
        ]
        Resource = module.dynamodb_orders.table_arn
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:DescribeStream",
          "dynamodb:GetRecords",
          "dynamodb:GetShardIterator",
          "dynamodb:ListStreams"
        ]
        Resource = module.dynamodb_orders.stream_arn
      }
    ]
  })

  tags = var.tags
}

# Configuración de CloudWatch Alarms para monitoreo
resource "aws_cloudwatch_metric_alarm" "dynamodb_throttled_requests" {
  alarm_name          = "${var.project}-dynamodb-throttled-requests-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ThrottledRequests"
  namespace           = "AWS/DynamoDB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "10"
  alarm_description   = "Alarma para solicitudes rechazadas en DynamoDB"
  alarm_actions       = []
  dimensions = {
    TableName = module.dynamodb_orders.table_name
  }

  tags = var.tags
}