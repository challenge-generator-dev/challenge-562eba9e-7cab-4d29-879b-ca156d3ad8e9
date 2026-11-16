# Outputs para el módulo DynamoDB
# Definición de outputs que exponen información relevante del módulo

output "table_arn" {
  description = "ARN de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.arn
}

output "table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.name
}

output "stream_arn" {
  description = "ARN del stream de DynamoDB"
  value       = aws_dynamodb_table.orders_table.stream_arn
}

output "table_id" {
  description = "ID de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders_table.id
}

output "global_secondary_index_names" {
  description = "Nombres de los índices secundarios globales"
  value       = [for idx in aws_dynamodb_table.orders_table.global_secondary_index : idx.name]
}

output "ttl_attribute" {
  description = "Atributo configurado para TTL"
  value       = var.ttl_attribute
}

output "backup_plan_arn" {
  description = "ARN del plan de backup (si está habilitado)"
  value       = var.backup_enabled ? aws_backup_plan.orders_backup_plan[0].arn : null
}

output "backup_plan_id" {
  description = "ID del plan de backup (si está habilitado)"
  value       = var.backup_enabled ? aws_backup_plan.orders_backup_plan[0].id : null
}

output "backup_selection_id" {
  description = "ID de la selección de backup (si está habilitado)"
  value       = var.backup_enabled ? aws_backup_selection.orders_backup_selection[0].id : null
}

output "kms_key_arn" {
  description = "ARN de la clave KMS utilizada para cifrado"
  value       = aws_dynamodb_table.orders_table.server_side_encryption[0].kms_key_arn
}