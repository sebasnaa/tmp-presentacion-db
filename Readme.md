# Connection-with-DB

Este repositorio contiene un flujo de trabajo automatizado utilizando GitHub Actions llamado "Connection-with-DB". El flujo de trabajo se configura para activarse en eventos de push a las ramas "master" y "dev", así como también se puede ejecutar manualmente a través de "workflow_dispatch".

## Objetivo

El objetivo de este flujo de trabajo es establecer una conexión con una base de datos MongoDB y realizar pruebas en un entorno de prueba. Luego, se puede proceder con la implementación del proyecto.

## Configuración

El flujo de trabajo utiliza las siguientes variables de entorno:

- `MONGODB_DB_NAME`: El nombre de la base de datos MongoDB que se utilizará en las pruebas y en la implementación.
- `PORT`: El puerto en el que se ejecutará el servidor.

Además, se requieren variables de entorno secretas para la conexión a la base de datos:

- `MONGODB_CLUSTER_ADDRESS`: La dirección del clúster MongoDB.
- `MONGODB_USERNAME`: El nombre de usuario de la cuenta de MongoDB.
- `MONGODB_PASSWORD`: La contraseña de la cuenta de MongoDB.

Asegúrate de configurar los secretos correspondientes en la configuración de secretos del repositorio para que el flujo de trabajo pueda acceder a ellos de forma segura.

## Flujo de trabajo

El flujo de trabajo consta de dos trabajos: "test" y "deploy".

### Trabajo "test"

El trabajo "test" se ejecuta en un entorno de prueba llamado "testing" y realiza las siguientes tareas:

1. Muestra las variables de entorno secretas disponibles en el contexto del flujo de trabajo.
2. Obtiene el código del repositorio.
3. Almacena en caché las dependencias de npm para acelerar futuras ejecuciones.
4. Instala las dependencias del proyecto utilizando "npm ci".
5. Ejecuta el servidor utilizando "npm start" y espera a que esté disponible en la dirección "http://127.0.0.1:$PORT".
6. Ejecuta pruebas utilizando "npm test".
7. Muestra información sobre la variable de entorno "MONGODB_USERNAME".

### Trabajo "deploy"

El trabajo "deploy" se ejecuta después del trabajo "test" debido a la declaración "needs: test". Realiza las siguientes tareas:

1. Muestra información sobre la fase de implementación.
2. Muestra información sobre las variables de entorno "MONGODB_USERNAME" y "MONGODB_DB_NAME".

El flujo de trabajo se ejecutará en una máquina virtual de Ubuntu con la última versión.

## Configuración adicional
Algunos ejemplos de las protecciones que se pueden configurar con las Deployment Protection Rules son:
- Requerir revisiones de código: Puedes establecer que las implementaciones deben ser revisadas y aprobadas por uno o más revisores antes de ser aplicadas.
- Requerir revisiones de aprobación: Puedes configurar que las implementaciones deben recibir una cierta cantidad de aprobaciones antes de ser aplicadas.
- Requerir comprobaciones de estado: Puedes especificar que las implementaciones deben pasar ciertas comprobaciones de estado (por ejemplo, pruebas unitarias exitosas) antes de ser aplicadas.
- Requerir revisiones de cambios de configuración: Puedes establecer que los cambios en la configuración del entorno de implementación deben ser revisados y aprobados antes de ser aplicados.

En este caso se ha agregado un `Required reviewers` en el momento de usar un `environment: testing
`