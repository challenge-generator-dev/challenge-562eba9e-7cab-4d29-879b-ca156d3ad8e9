# Componente de Infraestructura - Terraform

Este componente contiene la definición de infraestructura como código (IaC) para el sistema de gestión de órdenes de la fintech, utilizando Terraform con el proveedor de AWS.

## Propósito

Proporcionar la infraestructura necesaria para el almacenamiento y gestión de órdenes en DynamoDB, incluyendo:

- Tabla DynamoDB para persistencia de órdenes
- Políticas IAM para acceso a la tabla
- Alarmas CloudWatch para monitoreo
- Configuración de auto-scaling para capacidad adaptativa

## Estructura del Proyecto

```
infra/
├── environments/
│   └── dev/
│       ├── main.tf          # Configuración del módulo DynamoDB
│       ├── variables.tf     # Variables específicas del entorno
│       ├── outputs.tf       # Outputs del entorno
│       └── terraform.tfvars # Valores de variables
├── modules/
│   └── dynamodb/
│       ├── main.tf          # Definición de recursos DynamoDB
│       ├── variables.tf     # Variables del módulo
│       └── outputs.tf       # Outputs del módulo
├── versions.tf              # Versiones de Terraform y providers
└── providers.tf             # Configuración de providers
```

## Requisitos Previos

- Terraform >= 1.9.0 y < 2.0.0
- AWS CLI configurado con credenciales válidas
- Permisos para crear recursos en la cuenta de AWS

## Configuración Inicial

### 1. Configurar credenciales de AWS

```bash
aws configure
```

O configurar variables de entorno:

```bash
export AWS_ACCESS_KEY_ID="tu_access_key"
export AWS_SECRET_ACCESS_KEY="tu_secret_key"
export AWS_REGION="us-east-1"
```

### 2. Inicializar Terraform

```bash
cd environments/dev
terraform init
```

### 3. Planificar cambios

```bash
terraform plan -var-file="terraform.tfvars"
```

### 4. Aplicar infraestructura

```bash
terraform apply -var-file="terraform.tfvars"
```

## Uso del Módulo DynamoDB

El módulo `dynamodb` proporciona una tabla configurabe con las siguientes características:

### Parámetros Principales

| Variable | Descripción | Tipo | Requerido |
|----------|-------------|------|-----------|
| `table_name` | Nombre de la tabla | string | sí |
| `hash_key` | Clave de partición | string | sí |
| `billing_mode` | Modo de facturación | string | no |
| `read_capacity` | Capacidad de lectura | number | no |
| `write_capacity` | Capacidad de escritura | number | no |

### Ejemplo de Uso

```hcl
module "orders_table" {
  source = "../../modules/dynamodb"

  table_name   = "orders"
  hash_key     = "order_id"
  billing_mode = "PAY_PER_REQUEST"

  attributes = [
    { name = "order_id", type = "S" },
    { name = "customer_id", type = "S" },
    { name = "status", type = "S" }
  ]

  global_secondary_indexes = [
    {
      name            = "customer_status_index"
      hash_key        = "customer_id"
      projection_type = "ALL"
    }
  ]

  tags = {
    Environment = "dev"
    Project     = "fintech-orders"
  }
}
```

## Variables de Entorno

El sistema utiliza variables de entorno para la configuración de la aplicación. Estas se definen en `terraform.tfvars` y se inyectan en los contenedores mediante el Dockerfile.

### Variables de la Aplicación

| Variable | Descripción | Valor por defecto |
|----------|-------------|-------------------|
| `AWS_REGION` | Región de AWS | us-east-1 |
| `DYNAMODB_TABLE_NAME` | Nombre de la tabla | orders |
| `LOG_LEVEL` | Nivel de logging | INFO |

## Outputs Disponibles

Después de aplicar la infraestructura, Terraform expone los siguientes outputs:

- `dynamodb_table_arn`: ARN de la tabla creada
- `dynamodb_table_name`: Nombre de la tabla
- `dynamodb_stream_arn`: ARN del stream de DynamoDB (si está habilitado)
- `iam_policy_arn`: ARN de la política de acceso
- `cloudwatch_alarm_name`: Nombre de la alarma de throttling

## Limpieza de Recursos

Para destruir todos los recursos creados:

```bash
terraform destroy -var-file="terraform.tfvars"
```

## Notas de Seguridad

- Las credenciales de AWS nunca deben incluirse en el código fuente
- Usar roles IAM con permisos mínimos necesarios
- Habilitar cifrado en la tabla DynamoDB con KMS
- Configurar Point-in-Time Recovery para producción

## Tags Estándar

Todos los recursos incluyen los siguientes tags:

- `Environment`: Entorno de despliegue (dev, staging, prod)
- `Project`: Nombre del proyecto
- `ManagedBy`: Herramienta de gestión (terraform)
- `CostCenter`: Centro de costos para facturación