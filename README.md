# Entorno de Desarrollo Local - Sistema de Gestión

Este repositorio contiene la infraestructura Dockerizada necesaria para levantar una instancia local del Sistema de Gestión de cursos Moodle.

**Objetivo del entorno:**
1.  Desplegar el sistema en un entorno controlado (sandbox).
2.  Mapear y documentar los endpoints de la API REST.
3.  Analisis del codigo fuente

---

##  Requisitos Previos

Asegúrate de tener instalado en tu sistema:
* **Git**
* **Docker**
* **Docker Compose**  (Versión V2 o superior)
*  Tu editor de código favorito.

---

##  Guía de Instalación para Linux

Si usas distribuciones basadas en Linux, ejecuta estos comandos en tu terminal:

1. **Clonar el repositorio y entrar al directorio:**
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd nombre-del-proyecto
   ```

2. **Configurar el entorno:**
   Copia la plantilla para crear tu archivo local de variables.
   ```bash
   cp .env.example .env
   ```

3. **Levantar la infraestructura:**
   Ejecuta el siguiente comando (si tu usuario no tiene permisos sobre Docker, usa `sudo`):
   ```bash
   docker-compose up -d --build
   ```
   *Nota: La primera ejecución tomará unos minutos mientras se compilan las dependencias del contenedor de la aplicación.*

---

##  Guía de Instalación para Windows

Si estás en Windows, asegúrate de tener **Docker Desktop** activo.

1. **Clonar el repositorio:**
   Abre tu terminal (PowerShell o Git Bash) y ejecuta:
   ```powershell
   git clone <URL_DEL_REPOSITORIO>
   cd nombre-del-proyecto
   ```

2. **Configurar el entorno:**
   En PowerShell, el comando para copiar archivos es:
   ```powershell
   copy .env.example .env
   ```
   *(Verifica que el archivo `.env` se haya generado correctamente).*

3. **Levantar la infraestructura:**
   ```powershell
   docker-compose up -d --build
   ```

---

##  Configuración Inicial del Sistema

Una vez que los contenedores estén corriendo exitosamente, abre tu navegador e ingresa a:
 `http://localhost:8080`

El sistema te solicitará configurar la conexión a la base de datos por única vez. Completa los campos con los siguientes valores:
* **Host de la Base de Datos:** `moodle_db` (No usar `localhost`)
* **Nombre de la base de datos:** `moodle` (O el valor de tu variable `MYSQL_DATABASE`)
* **Usuario de la base de datos:** `moodle_user` (O el valor de tu variable `MYSQL_USER`)
* **Contraseña de la base de datos:** La que hayas definido en tu archivo `.env`
* **Prefijo de tablas:** `mdl_`

Continúa con el asistente para generar las tablas y crear tu cuenta de **Administrador** local.

---

##  Acceso al Código Fuente (Solo para Desarrollo)

El código de la aplicación se encuentra encapsulado en el contenedor. Si necesitas inspeccionar el ruteo interno o la lógica del sistema en tu IDE local, ejecuta este comando con el entorno encendido:

**Para Linux y Windows (Git Bash):**
```bash
docker cp moodle_app:/var/www/html ./codigo_fuente
```

Esto copiará los archivos a una carpeta llamada `codigo_fuente` en tu proyecto. Esta carpeta ya está ignorada en `.gitignore`, por lo que no afectará el repositorio.

---

##  Activación de la API

Para que el backend exponga permita llamadas a los endpoints, debes de activar la API
1. Ingresa al panel como **Administrador**.
2. Ve a `Características avanzadas` y habilita los **Servicios Web**.
3. En `Plugins > Servicios Web > Administrar protocolos`, activa **REST**.
4. Genera un **Token de acceso** desde la sección `Administrar tokens`.

---

##  Documentación Autogenerada

Puedes consultar la lista de endpoints y parámetros requeridos ingresando a:
`http://localhost:8080/admin/webservice/documentation.php`