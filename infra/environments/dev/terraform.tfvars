# Variables de entorno para desarrollo
# Configuración específica para el entorno de desarrollo

# Configuración general
environment = "dev"
project     = "fintech-orders"

# Configuración de DynamoDB
dynamodb_table_name = "orders-dev"
dynamodb_billing_mode = "PAY_PER_REQUEST"
dynamodb_hash_key     = "order_id"
dynamodb_range_key    = "created_at"

# Tags estándar para todos los recursos
tags = {
  Environment = "dev"
  Project     = "fintech-orders"
  ManagedBy   = "Terraform"
  Owner       = "backend-team"
}

# Configuración de índices secundarios
dynamodb_global_secondary_indexes = [
  {
    name            = "status-index"
    hash_key        = "status"
    projection_type = "ALL"
  },
  {
    name            = "customer-id-index"
    hash_key        = "customer_id"
    projection_type = "ALL"
  }
]

# Configuración de atributos de la tabla
dynamodb_attributes = [
  {
    name = "order_id"
    type = "S"
  },
  {
    name = "created_at"
    type = "S"
  },
  {
    name = "status"
    type = "S"
  },
  {
    name = "customer_id"
    type = "S"
  },
  {
    name = "product_details"
    type = "S"
  }
]

# Configuración de TTL (Time To Live)
dynamodb_ttl_attribute = "expiration_time"
dynamodb_ttl_enabled   = true

# Configuración de streams
dynamodb_stream_enabled   = true
dynamodb_stream_view_type = "NEW_AND_OLD_IMAGES"

# Configuración de capacidad (aunque usemos PAY_PER_REQUEST)
dynamodb_read_capacity  = 5
dynamodb_write_capacity = 5

# Configuración de backups
dynamodb_point_in_time_recovery_enabled = true
dynamodb_backup_enabled                 = true