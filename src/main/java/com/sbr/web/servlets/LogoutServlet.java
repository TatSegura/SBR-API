package com.sbr.web.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    // invalidar sesión
    HttpSession ses = req.getSession(false);
    if (ses != null) ses.invalidate();

    // no cache
    resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP/1.1
    resp.setHeader("Pragma", "no-cache"); // HTTP/1.0
    resp.setDateHeader("Expires", 0);     // Proxies

    // redirigir al login (mejor al servlet, no directamente al JSP)
    resp.sendRedirect(req.getContextPath() + "/LoginServlet");
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    doGet(req, resp);
  }
}


