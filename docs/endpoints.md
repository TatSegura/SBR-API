# ENDPOINTS – Support Bot Remote (SBR)

**Base URL local:** `http://localhost:8080/sbr`

| Endpoint | Método | Descripción | Body/Params | Respuesta esperada |
|---|---|---|---|---|
| `/LoginServlet` | GET | Muestra el formulario de login (cuando se invoca desde browser). | – | HTML (login.jsp) |
| `/LoginServlet` | POST | Valida credenciales contra BD y crea sesión. | `usuario`, `password` (`x-www-form-urlencoded`) | 200 OK + HTML (welcome.jsp) o 401/ mensaje error |
| `/LogoutServlet` | GET | Cierra la sesión y redirige al login. | – | 302 Redirect → `/login.jsp` |

**Notas**
- Las pruebas en Postman se hicieron con `x-www-form-urlencoded`.
- Usuario de prueba: `admin` – Password: `1234` (cambiable según BD).
- BD: MySQL (`sbr`, tabla `usuarios`).
