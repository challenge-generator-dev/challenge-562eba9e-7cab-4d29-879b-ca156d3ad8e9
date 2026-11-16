# Variables para el módulo DynamoDB
# Definición de variables de entrada para el módulo

variable "table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
}

variable "billing_mode" {
  description = "Modo de facturación para la tabla DynamoDB (PROVISIONED o PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"

  validation {
    condition     = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.billing_mode)
    error_message = "El modo de facturación debe ser PROVISIONED o PAY_PER_REQUEST."
  }
}

variable "hash_key" {
  description = "Clave hash (partition key) para la tabla DynamoDB"
  type        = string
}

variable "range_key" {
  description = "Clave de rango (sort key) para la tabla DynamoDB"
  type        = string
  default     = ""
}

variable "attributes" {
  description = "Lista de atributos para la tabla DynamoDB"
  type = list(object({
    name = string
    type = string
  }))
}

variable "global_secondary_indexes" {
  description = "Lista de índices secundarios globales para la tabla DynamoDB"
  type = list(object({
    name            = string
    hash_key        = string
    projection_type = string
  }))
  default = []
}

variable "ttl_attribute" {
  description = "Atributo para Time To Live (TTL)"
  type        = string
  default     = ""
}

variable "ttl_enabled" {
  description = "Habilitar Time To Live (TTL)"
  type        = bool
  default     = false
}

variable "stream_enabled" {
  description = "Habilitar stream para la tabla DynamoDB"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "Tipo de vista para el stream de DynamoDB"
  type        = string
  default     = "KEYS_ONLY"

  validation {
    condition     = contains(["KEYS_ONLY", "NEW_IMAGE", "OLD_IMAGE", "NEW_AND_OLD_IMAGES"], var.stream_view_type)
    error_message = "El tipo de vista del stream debe ser KEYS_ONLY, NEW_IMAGE, OLD_IMAGE o NEW_AND_OLD_IMAGES."
  }
}

variable "read_capacity" {
  description = "Capacidad de lectura provisionada (solo para modo PROVISIONED)"
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "Capacidad de escritura provisionada (solo para modo PROVISIONED)"
  type        = number
  default     = 5
}

variable "max_read_capacity" {
  description = "Capacidad máxima de lectura para auto-scaling (solo para modo PROVISIONED)"
  type        = number
  default     = 20
}

variable "max_write_capacity" {
  description = "Capacidad máxima de escritura para auto-scaling (solo para modo PROVISIONED)"
  type        = number
  default     = 20
}

variable "point_in_time_recovery" {
  description = "Habilitar recuperación punto en el tiempo para la tabla DynamoDB"
  type        = bool
  default     = false
}

variable "backup_enabled" {
  description = "Habilitar backups para la tabla DynamoDB"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "ARN de la clave KMS para cifrado"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags para aplicar a los recursos"
  type        = map(string)
  default     = {}
}