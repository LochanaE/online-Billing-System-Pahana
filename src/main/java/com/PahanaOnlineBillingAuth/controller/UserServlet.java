package com.PahanaOnlineBillingAuth.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.PahanaOnlineBilling.dao.UserDAO;
import com.PahanaOnlineBilling.util.FlashMessage;

import PahanaOnlineBilling.modal.User;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handle POST requests (Add, Update, Delete)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        UserDAO dao = new UserDAO();

        // Common inputs
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        boolean result = false;

        if ("add".equals(action)) {
            User user = new User(username, password, role);
            result = dao.addUser(user);
            FlashMessage.setMessage(request, result ? "success" : "danger",
                    result ? "User added successfully!" : "Failed to add user.");
        } 
        else if ("update".equals(action)) {
            User user = new User(username, password, role);
            result = dao.updateUser(user);
            FlashMessage.setMessage(request, result ? "success" : "danger",
                    result ? "User updated successfully!" : "Failed to update user.");
        } 
        else if ("delete".equals(action)) {
            result = dao.deleteUser(username);
            FlashMessage.setMessage(request, result ? "success" : "danger",
                    result ? "User deleted successfully!" : "Failed to delete user.");
        } 
        else {
            FlashMessage.setMessage(request, "danger", "Invalid action.");
        }

        // After any action, redirect back to the servlet (so doGet will refresh list)
        response.sendRedirect(request.getContextPath() + "/UserServlet");
    }

    // Handle GET requests (load user list and forward to JSP)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO dao = new UserDAO();
        List<User> userList = dao.getAllUsers();

        // attach list to request
        request.setAttribute("userList", userList);

        // forward to JSP
        request.getRequestDispatcher("/Views/User.jsp").forward(request, response);
    }
}
