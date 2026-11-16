# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `app/src/routes/orderRoutes.ts` — La fase "Definición y persistencia de órdenes" se implementa aqui: este archivo es el ejercicio.
- `app/src/application/services/OrderService.ts` — La practica caia en codigo que el entry no alcanza: este archivo alcanzable pasa a ser el ejercicio.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `app` | `app/` | practice, chapter | server | Node | Express, DynamoDB |
| `infra` | `infra/` | support | infra | Terraform (AWS) | Terraform |
| `infra-local` | (raiz) | support | infra | Compose local | DynamoDB |

## Orden de arranque

1. `docker compose up -d` (en la raiz) — levanta la infraestructura local.
2. `cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/dynamodb validate` — componente `infra` (support).
3. `cd app && npm install --no-audit --no-fund && npm run build` — componente `app` (practice, chapter).

### Contratos entre componentes

- `app` expone http (api: http://localhost:3000):
  - `POST /orders`
  - `GET /orders/:id`
  - `PUT /orders/:id`
  - `DELETE /orders/:id`

## Como saber que terminaste

```bash
(cd app && npm install --no-audit --no-fund && npm run build) && (cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/dynamodb validate) && docker compose config -q
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Node, Advanced L2

### Brecha de conocimiento
CRUD de ordenes en DynamoDB expuesto por una API REST, Implementa operaciones CRUD de ordenes sobre una tabla DynamoDB expuestas por una API REST

### Misión / candidato
Persistir y consultar ordenes

### Reto
- Tema: CRUD de ordenes sobre DynamoDB
- Seniority: advanced-l2
- Tipo: practical
- Título: Implementación de CRUD de órdenes en DynamoDB
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Definición y persistencia de órdenes — objetivo: Definir la estructura de las órdenes y permitir su persistencia en DynamoDB. — entregable (NO resolver): Especificación de la estructura de datos para órdenes y código que permite persistir una nueva orden en DynamoDB.
- Fase 2: Consulta y actualización de órdenes — objetivo: Implementar la consulta y actualización de órdenes existentes en DynamoDB. — entregable (NO resolver): Código que permite consultar y actualizar órdenes en DynamoDB, manejando correctamente los casos borde.
- Fase 3: Eliminación de órdenes y manejo de errores — objetivo: Implementar la eliminación de órdenes y asegurar un manejo robusto de errores. — entregable (NO resolver): Código que permite eliminar órdenes y documentación de las decisiones y trade-offs considerados.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: app/package.json ===
{
  "name": "reto-express",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "build": "tsc -p tsconfig.json"
  },
  "dependencies": {
    "@aws-sdk/client-dynamodb": "3.1169.0",
    "@aws-sdk/util-dynamodb": "3.996.9",
    "@types/uuid": "11.0.0",
    "dotenv": "18.0.10",
    "express": "4.22.3",
    "express-validator": "7.3.2",
    "inversify": "8.3.0",
    "uuid": "14.0.3"
  },
  "devDependencies": {
    "@types/express": "4.17.25",
    "@types/node": "22.20.5",
    "typescript": "5.7.3"
  }
}

// === ARCHIVO: app/tsconfig.json ===
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "commonjs",
    "moduleResolution": "node",
    "outDir": "dist",
    "strict": true,
    "strictPropertyInitialization": false,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "resolveJsonModule": true,
    "forceConsistentCasingInFileNames": true,
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,
    "types": [
      "node"
    ]
  },
  "include": [
    "src"
  ],
  "exclude": [
    "node_modules",
    "dist",
    "_pendiente",
    "tests",
    "test",
    "src/**/*.test.ts",
    "src/**/*.spec.ts"
  ]
}

// === ARCHIVO: app/src/domain/models/Order.ts ===
import { OrderStatus } from './OrderStatus';
import { ProductDetails } from './ProductDetails';

export interface Order {
    id: string;
    status: OrderStatus;
    createdAt: string;
    productDetails: ProductDetails;
}

export interface OrderCreateDto {
    productDetails: ProductDetails;
}

export interface OrderUpdateDto {
    status?: OrderStatus;
    productDetails?: ProductDetails;
}

export { OrderStatus } from './OrderStatus';
export { ProductDetails } from './ProductDetails';

// === ARCHIVO: app/src/domain/models/OrderStatus.ts ===
export type OrderStatus = 'PENDING' | 'COMPLETED' | 'CANCELLED';

// === ARCHIVO: app/src/domain/models/ProductDetails.ts ===
export interface ProductDetails {
    productId: string;
    quantity: number;
    price: number;
}

// === ARCHIVO: app/src/domain/repositories/OrderRepository.ts ===
import { Order, OrderCreateDto, OrderUpdateDto } from '../models/Order';

export interface OrderRepository {
    create(order: OrderCreateDto): Promise<Order>;
    findById(id: string): Promise<Order | null>;
    update(id: string, order: OrderUpdateDto): Promise<Order>;
    delete(id: string): Promise<void>;
}

// === ARCHIVO: app/src/application/services/OrderService.ts ===
// TODO(reto): archivo stubbeado; implementa los cuerpos.
import { Order, OrderCreateDto, OrderUpdateDto } from '../../domain/models/Order';
import { OrderRepository } from '../../domain/repositories/OrderRepository';
import { OrderStatus } from '../../domain/models/OrderStatus';
import { v4 as uuidv4 } from 'uuid';

export class OrderService {
    constructor(private orderRepository: OrderRepository) {}

    async createOrder(orderData: OrderCreateDto): Promise<Order> {
      throw new Error('TODO(reto): createOrder');
    }

    async getOrder(id: string): Promise<Order> {
      throw new Error('TODO(reto): getOrder');
    }

    async updateOrder(id: string, orderData: OrderUpdateDto): Promise<Order> {
      throw new Error('TODO(reto): updateOrder');
    }

    async deleteOrder(id: string): Promise<void> {
      throw new Error('TODO(reto): deleteOrder');
    }
}

// === ARCHIVO: app/src/infrastructure/controllers/OrderController.ts ===
import { Request, Response } from 'express';
import { OrderService } from '../../application/services/OrderService';
import { OrderCreateDto, OrderUpdateDto } from '../../domain/models/Order';
import { validationResult } from 'express-validator';

export class OrderController {
    constructor(private orderService: OrderService) {}

    async createOrder(req: Request, res: Response): Promise<void> {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            res.status(400).json({ errors: errors.array() });
            return;
        }

        try {
            const orderData: OrderCreateDto = req.body;
            const order = await this.orderService.createOrder(orderData);
            res.status(201).json(order);
        } catch (error) {
            res.status(500).json({ error: 'Internal server error' });
        }
    }

    async getOrder(req: Request, res: Response): Promise<void> {
        try {
            const { id } = req.params;
            const order = await this.orderService.getOrder(id);
            res.status(200).json(order);
        } catch (error) {
            if (error instanceof Error && error.message === 'Order not found') {
                res.status(404).json({ error: error.message });
            } else {
                res.status(500).json({ error: 'Internal server error' });
            }
        }
    }

    async updateOrder(req: Request, res: Response): Promise<void> {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            res.status(400).json({ errors: errors.array() });
            return;
        }

        try {
            const { id } = req.params;
            const orderData: OrderUpdateDto = req.body;
            const order = await this.orderService.updateOrder(id, orderData);
            res.status(200).json(order);
        } catch (error) {
            if (error instanceof Error && error.message === 'Order not found') {
                res.status(404).json({ error: error.message });
            } else if (error instanceof Error && error.message === 'Invalid order status') {
                res.status(400).json({ error: error.message });
            } else {
                res.status(500).json({ error: 'Internal server error' });
            }
        }
    }

    async deleteOrder(req: Request, res: Response): Promise<void> {
        try {
            const { id } = req.params;
            await this.orderService.deleteOrder(id);
            res.status(204).send();
        } catch (error) {
            if (error instanceof Error && error.message === 'Order not found') {
                res.status(404).json({ error: error.message });
            } else {
                res.status(500).json({ error: 'Internal server error' });
            }
        }
    }
}

// === ARCHIVO: app/src/infrastructure/repositories/DynamoOrderRepository.ts ===
// TODO(reto): archivo stubbeado; implementa los cuerpos.
import { Order } from '../../domain/models/Order';
import { OrderRepository } from '../../domain/repositories/OrderRepository';
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { PutItemCommand, GetItemCommand, UpdateItemCommand, DeleteItemCommand } from '@aws-sdk/client-dynamodb';
import { marshall, unmarshall } from '@aws-sdk/util-dynamodb';
import { injectable } from 'inversify';

@injectable()
export class DynamoOrderRepository implements OrderRepository {
    private readonly client: DynamoDBClient;
    private readonly tableName: string;

    constructor() {
        this.client = new DynamoDBClient({ region: process.env.AWS_REGION });
        this.tableName = process.env.DYNAMODB_TABLE_NAME || 'Orders';
    }

    async create(order: Order): Promise<Order> {
      throw new Error('TODO(reto): create');
    }

    async findById(id: string): Promise<Order | null> {
      throw new Error('TODO(reto): findById');
    }

    async update(id: string, order: Partial<Order>): Promise<Order> {
      throw new Error('TODO(reto): update');
    }

    async delete(id: string): Promise<void> {
      throw new Error('TODO(reto): delete');
    }
}

// === ARCHIVO: app/src/routes/orderRoutes.ts ===
// TODO(reto): archivo stubbeado; implementa los cuerpos.
import { Router, Request, Response } from 'express';
import { OrderController } from '../infrastructure/controllers/OrderController';
import { OrderService } from '../application/services/OrderService';
import { body, param } from 'express-validator';

const router = Router();

export const OrderRoutes = (orderService: OrderService): Router => {
    const orderController = new OrderController(orderService);

    router.post(
        '/orders',
        [
            body('productDetails.productId').isString().notEmpty(),
            body('productDetails.quantity').isInt({ min: 1 }),
            body('productDetails.price').isFloat({ min: 0 })
        ],
        (req: Request, res: Response) => orderController.createOrder(req, res)
    );

    router.get(
        '/orders/:id',
        [
            param('id').isString().notEmpty()
        ],
        (req: Request, res: Response) => orderController.getOrder(req, res)
    );

    router.put(
        '/orders/:id',
        [
            param('id').isString().notEmpty(),
            body('status').optional().isIn(['PENDING', 'COMPLETED', 'CANCELLED']),
            body('productDetails').optional(),
            body('productDetails.productId').optional().isString().notEmpty(),
            body('productDetails.quantity').optional().isInt({ min: 1 }),
            body('productDetails.price').optional().isFloat({ min: 0 })
        ],
        (req: Request, res: Response) => orderController.updateOrder(req, res)
    );

    router.delete(
        '/orders/:id',
        [
            param('id').isString().notEmpty()
        ],
        (req: Request, res: Response) => orderController.deleteOrder(req, res)
    );

    return router;
};

export default router;

// === ARCHIVO: app/src/main.ts ===
import 'reflect-metadata';
import dotenv from 'dotenv';
import { app } from './app';

dotenv.config();

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Servidor escuchando en el puerto ${PORT}`);
});

// === ARCHIVO: app/src/app.ts ===
import express, { Application, Request, Response, NextFunction } from 'express';
import { OrderService } from './application/services/OrderService';
import { DynamoOrderRepository } from './infrastructure/repositories/DynamoOrderRepository';
import orderRoutes from './routes/orderRoutes';

export const app: Application = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const orderRepository = new DynamoOrderRepository();
const orderService = new OrderService(orderRepository);

app.use('/', orderRoutes(orderService));

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    console.error('Error no manejado:', err);
    res.status(500).json({
        error: 'Error interno del servidor',
        message: err.message
    });
});

app.get('/health', (req: Request, res: Response) => {
    res.status(200).json({ status: 'OK' });
});

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.100.0"
    }
  }
}

// === ARCHIVO: infra/providers.tf ===
provider "aws" {
  region = "us-east-1"
}

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
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

// === ARCHIVO: infra/environments/dev/main.tf ===
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

// === ARCHIVO: infra/environments/dev/outputs.tf ===
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

// === ARCHIVO: infra/modules/dynamodb/main.tf ===
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

// === ARCHIVO: infra/modules/dynamodb/variables.tf ===
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

// === ARCHIVO: infra/modules/dynamodb/outputs.tf ===
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

// === ARCHIVO: infra/README.md ===
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

// === ARCHIVO: infra/environments/dev/variables.tf ===
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

// === ARCHIVO: docker-compose.yml ===
# Infraestructura local del reto. SOLO desarrollo: credenciales de ejemplo (local-dev-only), puertos en loopback.
# Levantar: docker compose up -d --wait
name: infra-local
services:
  dynamodb-local:
    image: "amazon/dynamodb-local:2.5.2"
    command: ["-jar","DynamoDBLocal.jar","-sharedDb","-inMemory"]
    ports:
      - "127.0.0.1:8000:8000"
    healthcheck:
      test: ["CMD-SHELL","bash -c ':> /dev/tcp/127.0.0.1/8000' || exit 1"]
      interval: 10s
      timeout: 5s
      retries: 10
      start_period: 5s


// === ARCHIVO: infra-local/README.md ===
# Infraestructura local

Servicios de soporte para el reto, definidos en `docker-compose.yml` (raiz del repo).

```bash
docker compose up -d --wait
```

| Servicio | Imagen | Puertos (host) |
|---|---|---|
| DynamoDB Local | `amazon/dynamodb-local:2.5.2` | 8000 |

Credenciales: solo de desarrollo local (`local-dev-only`, `local`). No son secretos ni deben reutilizarse.
Los scripts de `infra-local/` (tablas, topics) se ejecutan con el compose en estado healthy.


// === ARCHIVO: infra-local/dynamodb/create-tables.sh ===
#!/usr/bin/env bash
# Crea las tablas en DynamoDB Local (idempotente). Credenciales dummy: DynamoDB Local no valida firmas.
set -euo pipefail

export AWS_ACCESS_KEY_ID=local
export AWS_SECRET_ACCESS_KEY=local
export AWS_REGION=us-east-1
ENDPOINT="${DYNAMODB_ENDPOINT:-http://localhost:8000}"

create_table() {
  local name="$1" pk="$2" sk="${3:-}"
  if aws dynamodb describe-table --table-name "$name" --endpoint-url "$ENDPOINT" >/dev/null 2>&1; then
    echo "Tabla $name ya existe"
    return
  fi
  local attrs="AttributeName=$pk,AttributeType=S"
  local keys="AttributeName=$pk,KeyType=HASH"
  if [ -n "$sk" ]; then
    attrs="$attrs AttributeName=$sk,AttributeType=S"
    keys="$keys AttributeName=$sk,KeyType=RANGE"
  fi
  # shellcheck disable=SC2086
  aws dynamodb create-table --table-name "$name" --attribute-definitions $attrs --key-schema $keys \
    --billing-mode PAY_PER_REQUEST --endpoint-url "$ENDPOINT" >/dev/null
  echo "Tabla $name creada"
}

create_table "app-items" "id"

```
