/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.sbr.web.servlets;

import com.sbr.web.db.DB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // muestra el formulario
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String usuario  = req.getParameter("usuario");
        String password = req.getParameter("password");

        try (Connection cn = DB.getConnection();
             PreparedStatement ps = cn.prepareStatement(
                 "SELECT id, nombre FROM usuarios WHERE usuario=? AND password=?")) {

            ps.setString(1, usuario);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    HttpSession ses = req.getSession(true);
                    ses.setAttribute("usuario", usuario);
                    ses.setAttribute("nombre", rs.getString("nombre"));
                    // redirige a la vista de bienvenida (ajusta el nombre si usas otra)
                    resp.sendRedirect(req.getContextPath() + "/welcome.jsp");
                } else {
                    req.setAttribute("error", "Usuario o contraseña incorrectos");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error al consultar la base de datos", e);
        }
    }
}
