# Implementación de CRUD de órdenes en DynamoDB

El sistema de gestión de órdenes de una fintech requiere la implementación de operaciones CRUD sobre una tabla DynamoDB. La API REST expondrá estas operaciones para permitir a los clientes realizar, consultar, actualizar y eliminar órdenes. Los clientes son los usuarios de la fintech y el sumidero es la tabla DynamoDB. Cada orden tiene un identificador único, un estado, una fecha de creación y detalles del producto. El sistema debe manejar casos borde como órdenes con identificadores duplicados y estados inválidos.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | CRUD de ordenes sobre DynamoDB |
| **Nivel** | advanced-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Node.js 18+, npm, VS Code o similar.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Ejecuta `npm install && npm run build` (o `npm start`). Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Definición y persistencia de órdenes

**Objetivo:** Definir la estructura de las órdenes y permitir su persistencia en DynamoDB.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Diseña la estructura de datos para las órdenes, incluyendo identificador único, estado, fecha de creación y detalles del producto.
- Implementa la lógica para persistir una nueva orden en DynamoDB.
- Asegúrate de que el sistema maneje correctamente los identificadores duplicados.

**Entregable:** Especificación de la estructura de datos para órdenes y código que permite persistir una nueva orden en DynamoDB.

<details>
<summary>Pistas de conocimiento</summary>

- Considera los atributos necesarios para una orden y cómo deben estructurarse en DynamoDB.
- Piensa en cómo manejarías los identificadores duplicados para evitar inconsistencias en los datos.

</details>

### Fase 2: Consulta y actualización de órdenes

**Objetivo:** Implementar la consulta y actualización de órdenes existentes en DynamoDB.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Implementa la lógica para consultar una orden por su identificador.
- Agrega la funcionalidad para actualizar los detalles de una orden existente.
- Considera los casos borde, como órdenes con estados inválidos o detalles faltantes.

**Entregable:** Código que permite consultar y actualizar órdenes en DynamoDB, manejando correctamente los casos borde.

<details>
<summary>Pistas de conocimiento</summary>

- Piensa en cómo validarías los datos de entrada para asegurar la integridad de las órdenes.
- Considera las posibles transiciones de estado de una orden y cómo manejarías los estados inválidos.

</details>

### Fase 3: Eliminación de órdenes y manejo de errores

**Objetivo:** Implementar la eliminación de órdenes y asegurar un manejo robusto de errores.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Implementa la lógica para eliminar una orden por su identificador.
- Asegura un manejo robusto de errores para todas las operaciones CRUD.
- Documenta las decisiones tomadas y los trade-offs considerados durante el desarrollo.

**Entregable:** Código que permite eliminar órdenes y documentación de las decisiones y trade-offs considerados.

<details>
<summary>Pistas de conocimiento</summary>

- Considera los posibles errores que pueden ocurrir durante las operaciones CRUD y cómo los manejarías.
- Piensa en los trade-offs entre consistencia y disponibilidad al implementar las operaciones CRUD.

</details>

## Dimensiones Evaluadas

- **queEs**: En fase 1, ¿qué es una orden y cuáles son sus atributos esenciales?
- **paraQueSirve**: En fase 2, ¿para qué sirve la consulta y actualización de órdenes y cómo se asegura la integridad de los datos?
- **comoSeUsa**: En fase 3, ¿cómo se usa la eliminación de órdenes y qué errores se deben manejar?
- **erroresComunes**: En todas las fases, ¿cuáles son los errores comunes que pueden ocurrir durante las operaciones CRUD y cómo se manejan?
- **queDecisionesImplica**: En fase 3, ¿qué decisiones implica la implementación de las operaciones CRUD y qué trade-offs se consideran?

## Criterios de Evaluacion

- Definición y persistencia correcta de órdenes en DynamoDB.
- Consulta y actualización correcta de órdenes, manejando casos borde.
- Eliminación correcta de órdenes y manejo robusto de errores.
- Documentación clara de decisiones y trade-offs considerados.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd app && npm install --no-audit --no-fund && npm run build) && (cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/dynamodb validate) && docker compose config -q
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
