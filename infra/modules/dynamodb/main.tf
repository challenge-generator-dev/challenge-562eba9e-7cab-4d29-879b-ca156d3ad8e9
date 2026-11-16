# Módulo DynamoDB para creación de tablas de órdenes
# Configuración principal incluyendo recursos y lógica

resource "aws_dynamodb_table" "orders_table" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key
  range_key      = var.range_key

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name            = global_secondary_index.value.name
      hash_key        = global_secondary_index.value.hash_key
      projection_type = global_secondary_index.value.projection_type
    }
  }

  ttl {
    attribute_name = var.ttl_attribute
    enabled        = var.ttl_enabled
  }

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_enabled ? var.stream_view_type : null

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = var.kms_key_arn != "" ? var.kms_key_arn : null
  }

  tags = merge(var.tags, { Name = var.table_name })

  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity
    ]
  }
}

# Configuración de backups para la tabla DynamoDB usando AWS Backup
resource "aws_backup_plan" "orders_backup_plan" {
  count = var.backup_enabled ? 1 : 0

  name = "${var.table_name}-backup-plan"

  rule {
    rule_name                = "DailyBackup"
    target_vault_name        = "default"
    schedule                 = "cron(0 12 * * ? *)"
    start_window             = 60
    completion_window        = 180
    enable_continuous_backup = false
    lifecycle {
      cold_storage_after = 30
      delete_after       = 90
    }
  }

  tags = var.tags
}

resource "aws_backup_selection" "orders_backup_selection" {
  count = var.backup_enabled ? 1 : 0

  name     = "${var.table_name}-backup-selection"
  plan_id  = aws_backup_plan.orders_backup_plan[0].id
  iam_role_arn = aws_iam_role.backup_role[0].arn

  resources = [
    aws_dynamodb_table.orders_table.arn
  ]
}

# Rol IAM para AWS Backup
resource "aws_iam_role" "backup_role" {
  count = var.backup_enabled ? 1 : 0

  name = "${var.table_name}-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backup_role_policy" {
  count = var.backup_enabled ? 1 : 0

  role       = aws_iam_role.backup_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

# Configuración de auto-scaling para la tabla DynamoDB
resource "aws_appautoscaling_target" "dynamodb_read_target" {
  count = var.billing_mode == "PROVISIONED" ? 1 : 0

  max_capacity       = var.max_read_capacity
  min_capacity       = var.read_capacity
  resource_id        = "table/${aws_dynamodb_table.orders_table.name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_read_policy" {
  count = var.billing_mode == "PROVISIONED" ? 1 : 0

  name               = "${var.table_name}-read-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_read_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_read_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_read_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }
    target_value       = 70
    scale_in_cooldown  = 60
    scale_out_cooldown = 60
  }
}

resource "aws_appautoscaling_target" "dynamodb_write_target" {
  count = var.billing_mode == "PROVISIONED" ? 1 : 0

  max_capacity       = var.max_write_capacity
  min_capacity       = var.write_capacity
  resource_id        = "table/${aws_dynamodb_table.orders_table.name}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_write_policy" {
  count = var.billing_mode == "PROVISIONED" ? 1 : 0

  name               = "${var.table_name}-write-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_write_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_write_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_write_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }
    target_value       = 70
    scale_in_cooldown  = 60
    scale_out_cooldown = 60
  }
}