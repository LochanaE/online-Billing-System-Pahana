package com.PahanaOnlineBillingAuth.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.PahanaOnlineBilling.dao.UserDAO;

import PahanaOnlineBilling.modal.User;

@WebServlet("/Loginservlet")
public class Loginservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	 protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        String username = request.getParameter("username");
	        String password = request.getParameter("password");

	        UserDAO dao = new UserDAO();
	        User user = dao.authenticate(username, password);

	        if (user != null) {
	            HttpSession session = request.getSession();
	            session.setAttribute("user", user);
	            response.sendRedirect("Views/DashBoard.jsp");
	        } else {
	            response.sendRedirect("Views/login.jsp?error=Invalid+username+or+password");
	        }
	    }
	 
	 
}
	
