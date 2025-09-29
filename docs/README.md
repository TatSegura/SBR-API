# SBR-API (Support Bot Remote)

Evidencias y documentación de la API del proyecto **Support Bot Remote**.

## 🧪 ¿Qué incluye este repo?
- Código fuente de la app web (Java + JSP + Servlets) en `src/main/webapp`.
- Conexión a MySQL (clase `DB.java`).
- Colección de **Postman** para probar el login: `docs/SBR-API.postman_collection.json`.
- Capturas de pruebas en `docs/capturas/`.
- Archivo de endpoints en `docs/ENDPOINTS.md` (o `.txt`).

---

## 🚀 Cómo ejecutar
### Requisitos
- JDK 21 (o compatible con tu IDE).
- Apache Tomcat 10+ (o el que uses en NetBeans).
- MySQL 8.
- IDE: NetBeans/Eclipse/IntelliJ (probado en NetBeans).

### Base de datos
Usar la BD `sbr` y la tabla `usuarios` con estas columnas mínimas:

```sql
CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE,
  direccion VARCHAR(150)
);

