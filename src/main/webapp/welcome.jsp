<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // --- anti-caché (poner ANTES de generar cualquier salida) ---
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0);     // Proxies

    // --- Sesión obligatoria ---
    String nombre  = (String) session.getAttribute("nombre");
    String usuario = (String) session.getAttribute("usuario");
    if (usuario == null) {
        // mejor vuelve al LoginServlet, que a su vez muestra login.jsp
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }

    // --- Saludo dinámico ---
    java.time.LocalTime t = java.time.LocalTime.now();
    String saludo = t.isBefore(java.time.LocalTime.NOON) ? "¡Buenos días"
                   : (t.isBefore(java.time.LocalTime.of(18,0)) ? "¡Buenas tardes" : "¡Buenas noches");
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Bienvenido</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Preload del fondo para sentirlo más “instantáneo” -->
  <link rel="preload" as="image" href="<%=request.getContextPath()%>/img/welcofondo.png">

  <style>
    :root{
      --glass: rgba(255,255,255,.18);
      --glass-border: rgba(255,255,255,.35);
      --grad1: #0d6efd;
      --grad2: #0a4fa3;
    }

    html, body {
      height: 100%;
    }
    body {
      margin: 0;
      background: url("<%=request.getContextPath()%>/img/welcofondo.png") no-repeat center center fixed;
      background-size: cover;
      font-family: 'Segoe UI', system-ui, -apple-system, Arial, sans-serif;
      display: grid;
      place-items: center;
      position: relative;
      color: #fff;
    }

    /* capa tenue para mejorar contraste del texto */
    .bg-overlay{
      position: fixed; inset: 0;
      background: radial-gradient(ellipse at center, rgba(0,0,0,.18), rgba(0,0,0,.38) 70%);
      z-index: 0;
    }

    .welcome-card{
      position: relative;
      z-index: 1;
      width: min(640px, 92vw);
      padding: 40px 32px;
      border-radius: 20px;
      background: var(--glass);
      border: 1px solid var(--glass-border);
      box-shadow: 0 10px 30px rgba(0,0,0,.35);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      text-align: center;
    }

    .title{
      font-weight: 800;
      font-size: clamp(1.6rem, 2.6vw + 1rem, 2.4rem);
      margin-bottom: .25rem;
      background: linear-gradient(90deg, var(--grad1), var(--grad2));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      text-shadow: 0 1px 2px rgba(0,0,0,.25);
    }

    .subtitle{
      font-size: 1.05rem;
      margin-bottom: 1.2rem;
      color: #f2f2f2;
      opacity: .95;
    }

    .btn-grad{
      background: linear-gradient(90deg, var(--grad1), var(--grad2));
      border: none;
      color: #fff !important;
    }
    .btn-grad:hover{
      background: linear-gradient(90deg, var(--grad2), var(--grad1));
      transform: translateY(-1px);
    }

    .btn-outline-light{
      border-color: rgba(255,255,255,.65);
      color: #fff;
    }
    .btn-outline-light:hover{
      background: rgba(255,255,255,.12);
      border-color: #fff;
      color: #fff;
    }

    @media (max-width: 480px){
      .welcome-card{ padding: 28px 22px; }
    }
  </style>
</head>
<body>
  <div class="bg-overlay"></div>

  <main class="welcome-card">
    <h1 class="title"><%= saludo %>, <%= (nombre != null && !nombre.isBlank()) ? nombre : usuario %> 👋</h1>
    <p class="subtitle">Has iniciado sesión correctamente en <strong>Support Bot Remote</strong>.</p>
    
    <div class="d-grid gap-2 d-sm-flex justify-content-center mt-3">
  <a class="btn btn-grad px-4" href="<%= request.getContextPath() %>/LogoutServlet">Cerrar sesión</a>
</div>


    <hr class="border-light opacity-50 my-4" />
    <small class="opacity-75">© 2025 Support Bot Remote. Todos los derechos reservados.</small>
  </main>
</body>
</html>
