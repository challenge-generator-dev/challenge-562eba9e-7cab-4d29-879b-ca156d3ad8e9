# Variables para el entorno de desarrollo
# Configuración específica del entorno de desarrollo para la infraestructura de órdenes

variable "environment" {
  description = "Nombre del entorno de despliegue"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser: dev, staging o prod."
  }
}

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "La región debe tener el formato correcto de AWS (ej. us-east-1)."
  }
}

variable "project" {
  description = "Nombre del proyecto para identificar recursos"
  type        = string
  default     = "fintech-orders"
}

variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para almacenar órdenes"
  type        = string
  default     = "orders"
}

variable "dynamodb_billing_mode" {
  description = "Modo de facturación de la tabla DynamoDB"
  type        = string
  default     = "PAY_PER_REQUEST"

  validation {
    condition     = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.dynamodb_billing_mode)
    error_message = "El modo de facturación debe ser PROVISIONED o PAY_PER_REQUEST."
  }
}

variable "dynamodb_hash_key" {
  description = "Nombre del atributo de clave de partición"
  type        = string
  default     = "order_id"
}

variable "dynamodb_range_key" {
  description = "Nombre del atributo de clave de ordenación"
  type        = string
  default     = ""
}

variable "dynamodb_attributes" {
  description = "Lista de atributos definidos para la tabla"
  type = list(object({
    name = string
    type = string
  }))
  default = [
    { name = "order_id", type = "S" },
    { name = "customer_id", type = "S" },
    { name = "status", type = "S" },
    { name = "created_at", type = "S" }
  ]

  validation {
    condition     = length(var.dynamodb_attributes) > 0
    error_message = "Debe definir al menos un atributo para la tabla."
  }
}

variable "dynamodb_global_secondary_indexes" {
  description = "Configuración de índices secundarios globales"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = string
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = [
    {
      name            = "customer_status_index"
      hash_key        = "customer_id"
      range_key       = "status"
      projection_type = "ALL"
      read_capacity   = 5
      write_capacity  = 5
    },
    {
      name            = "status_created_index"
      hash_key        = "status"
      range_key       = "created_at"
      projection_type = "ALL"
      read_capacity   = 5
      write_capacity  = 5
    }
  ]
}

variable "dynamodb_ttl_attribute" {
  description = "Nombre del atributo que contiene la fecha de expiración"
  type        = string
  default     = "expires_at"
}

variable "dynamodb_ttl_enabled" {
  description = "Habilitar Time To Live para eliminación automática"
  type        = bool
  default     = false
}

variable "dynamodb_stream_enabled" {
  description = "Habilitar streams de DynamoDB para captura de cambios"
  type        = bool
  default     = true
}

variable "dynamodb_stream_view_type" {
  description = "Tipo de información incluida en el stream"
  type        = string
  default     = "NEW_AND_OLD_IMAGES"

  validation {
    condition     = contains(["KEYS_ONLY", "NEW_IMAGE", "OLD_IMAGE", "NEW_AND_OLD_IMAGES"], var.dynamodb_stream_view_type)
    error_message = "El tipo de vista debe ser: KEYS_ONLY, NEW_IMAGE, OLD_IMAGE o NEW_AND_OLD_IMAGES."
  }
}

variable "dynamodb_read_capacity" {
  description = "Capacidad de lectura provisionada (solo para modo PROVISIONED)"
  type        = number
  default     = 5

  validation {
    condition     = var.dynamodb_read_capacity >= 1 && var.dynamodb_read_capacity <= 40000
    error_message = "La capacidad de lectura debe estar entre 1 y 40000 unidades."
  }
}

variable "dynamodb_write_capacity" {
  description = "Capacidad de escritura provisionada (solo para modo PROVISIONED)"
  type        = number
  default     = 5

  validation {
    condition     = var.dynamodb_write_capacity >= 1 && var.dynamodb_write_capacity <= 40000
    error_message = "La capacidad de escritura debe estar entre 1 y 40000 unidades."
  }
}

variable "dynamodb_point_in_time_recovery_enabled" {
  description = "Habilitar recuperación punto en el tiempo"
  type        = bool
  default     = false
}

variable "dynamodb_backup_enabled" {
  description = "Habilitar backups automáticos"
  type        = bool
  default     = true
}

variable "project_name" {
  description = "Nombre del proyecto para identificar recursos (legacy, usar 'project' en su lugar)"
  type        = string
  default     = "fintech-orders"
}

variable "max_read_capacity" {
  description = "Capacidad máxima de lectura para auto-scaling"
  type        = number
  default     = 20
}

variable "max_write_capacity" {
  description = "Capacidad máxima de escritura para auto-scaling"
  type        = number
  default     = 20
}

variable "kms_key_arn" {
  description = "ARN de la clave KMS para cifrado en reposo"
  type        = string
  default     = ""
}

variable "enable_deletion_protection" {
  description = "Habilitar protección contra eliminación accidental"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags adicionales para aplicar a todos los recursos"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "fintech-orders"
    ManagedBy   = "terraform"
  }
}

variable "alarm_throttle_threshold" {
  description = "Umbral de requests throttled para activar alarma"
  type        = number
  default     = 5
}

variable "alarm_evaluation_periods" {
  description = "Número de períodos de evaluación para la alarma"
  type        = number
  default     = 2
}

variable "alarm_period_seconds" {
  description = "Período de evaluación en segundos"
  type        = number
  default     = 300
}