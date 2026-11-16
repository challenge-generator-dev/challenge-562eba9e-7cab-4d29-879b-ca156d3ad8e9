# Outputs para el entorno de desarrollo
# Información relevante de los recursos desplegados

output "dynamodb_table_arn" {
  description = "ARN de la tabla DynamoDB de órdenes"
  value       = module.dynamodb_orders.table_arn
}

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB de órdenes"
  value       = module.dynamodb_orders.table_name
}

output "dynamodb_stream_arn" {
  description = "ARN del stream de DynamoDB"
  value       = module.dynamodb_orders.stream_arn
}

output "dynamodb_global_secondary_indexes" {
  description = "Información de los índices secundarios globales"
  value = [
    for idx in var.dynamodb_global_secondary_indexes :
    {
      name       = idx.name
      hash_key   = idx.hash_key
      projection = idx.projection_type
    }
  ]
}

output "iam_policy_arn" {
  description = "ARN de la política IAM para acceso a DynamoDB"
  value       = aws_iam_policy.dynamodb_access_policy.arn
}

output "cloudwatch_alarm_name" {
  description = "Nombre de la alarma de CloudWatch para throttled requests"
  value       = aws_cloudwatch_metric_alarm.dynamodb_throttled_requests.alarm_name
}

output "tags" {
  description = "Tags aplicados a los recursos"
  value       = var.tags
}