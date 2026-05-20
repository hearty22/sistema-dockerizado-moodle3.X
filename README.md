# Entorno de Simulación Moodle

Infraestructura Dockerizada

## Cómo levantar el entorno

1. Clonar el repositorio.
2. Copiar la plantilla de variables de entorno:
   `cp .env.example .env`
3. Rellenar el `.env` con las contraseñas que desees.
4. Levantar los contenedores (va a demorar la primera vez por la compilación de PHP 5.6):
   `docker-compose up -d --build`

## Configuración inicial de Moodle

Ingresar a `http://localhost:8080`. Cuando pida los datos de la base de datos, usar:
* **Host:** `moodle_db`
* **Base de datos / Usuario / Pass:** Los que hayas definido en tu `.env`.

## Extraer código fuente para auditar

Para abrir el código PHP de Moodle en tu IDE local sin romper el contenedor, ejecuta:
`docker cp moodle_app:/var/www/html ./codigo_moodle`
(Esta carpeta está en el `.gitignore` por defecto).