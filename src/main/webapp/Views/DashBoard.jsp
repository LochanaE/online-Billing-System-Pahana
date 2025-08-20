<%@ page session="true" %>
<%@ page import="PahanaOnlineBilling.modal.User" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("Views/login.jsp");
        return;
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Dashboard - Pahana Edu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
  body { background-color: #F3F4F6; font-family: 'Segoe UI', sans-serif; color: #111827; }
  .card { border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); background-color: #ffffff; color: #111827; transition: 0.3s; }
  .card:hover { transform: translateY(-3px); box-shadow: 0 12px 28px rgba(0,0,0,0.15); }
  h3 { font-weight: 600; }
  .text-warning { color: #FACC15 !important; }
  .btn-custom { background-color: #2563EB; color: #ffffff; font-weight: 600; transition: 0.3s; }
  .btn-custom:hover { background-color: #1E40AF; }
  .card-icon { font-size: 2rem; color: #10B981; }
  .navbar-brand { font-weight: 600; }
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm mb-4">
  <div class="container-fluid">
    
    <!-- Left side -->
    <div class="d-flex align-items-center">
      <a class="navbar-brand text-warning" href="<%= request.getContextPath() %>/Views/DashBoard.jsp">
        <i class="fas fa-book-open"></i> Pahana Edu
      </a>
      <a class="nav-link text-primary ms-3 fw-semibold" href="<%= request.getContextPath() %>/Views/DashBoard.jsp">
        <i class="fas fa-tachometer-alt"></i> Dashboard
      </a>
    </div>

    <!-- Right side -->
    <ul class="navbar-nav ms-auto d-flex align-items-center">
      
      <!-- Avatar + Username + Role -->
      <li class="nav-item d-flex align-items-center me-3">
        <%
            String fillColor = "0d6efd"; // default blue for User
            if ("Admin".equalsIgnoreCase(user.getRole())) {
                fillColor = "ffc107"; // Admin → gold
            }
        %>
        <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" viewBox="0 0 24 24" class="me-2">
          <path fill="#<%= fillColor %>" d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
        </svg>
        <span class="fw-semibold text-dark">
          <%= user.getUsername() %> 
          <small class="text-muted">(<%= user.getRole() %>)</small>
        </span>
      </li>

      <!-- Logout -->
      <li class="nav-item">
        <a class="nav-link text-danger" href="<%= request.getContextPath() %>/LogoutServlet">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </li>
      
    </ul>
  </div>
</nav>

<div class="container py-4">

  <h3 class="mb-4 text-warning"><i class="fas fa-tachometer-alt"></i> Dashboard</h3>

  <div class="row g-4">


    <!-- Manage Customers Card -->
    <div class="col-md-4">
      <div class="card p-4 text-center">
        <i class="fas fa-users card-icon mb-3"></i>
        <h5>Manage Customers</h5>
        <p class="text-muted">Add,View, edit or delete existing customers.</p>
        
        <a href="<%= request.getContextPath() %>/CustomerServlet" class="btn btn-custom"><i class="fas fa-arrow-right"></i> Go</a>
      </div>
    </div>
    <!-- Manage Books Card -->
<div class="col-md-4">
  <div class="card p-4 text-center">
    <i class="fas fa-boxes card-icon mb-3"></i>
    <h5>Inventory</h5>
    <p class="text-muted">Add, view, edit, or delete Items in your store.</p>
    <a href="<%= request.getContextPath() %>/ItemServlet" class="btn btn-custom">
      <i class="fas fa-arrow-right"></i> Go
    </a>
  </div>
</div>
    

    <!-- Reports Card -->
    <div class="col-md-4">
      <div class="card p-4 text-center">
        <i class="fas fa-file-invoice card-icon mb-3"></i>
        <h5>Billing</h5>
        <p class="text-muted">Generate billing and usage reports.</p>
        <a href="<%= request.getContextPath() %>/BillingServlet" class="btn btn-custom"><i class="fas fa-arrow-right"></i> Go</a>
      </div>
    </div>

    <!-- Users Card -->
    <div class="col-md-4">
      <div class="card p-4 text-center">
        <i class="fas fa-users card-icon mb-3"></i>
        <h5>Users</h5>
        <p class="text-muted">Manage users.</p>
        <a href="<%= request.getContextPath() %>/UserServlet" class="btn btn-custom"><i class="fas fa-arrow-right"></i> Go</a>
      </div>
    </div>
     <!-- sales and reports Card -->
     <div class="col-md-4">
      <div class="card p-4 text-center">
        <i class="fas fa-chart-line card-icon mb-3"></i>
        <h5>Sales & Reports</h5>
        <p class="text-muted">View detailed sales and usage reports.</p>
        <a href="<%= request.getContextPath() %>/Views/Sales.jsp" class="btn btn-custom"><i class="fas fa-arrow-right"></i> Go</a>
      </div>
    </div>

    <!-- Help Card -->
    <div class="col-md-4">
  <div class="card p-4 text-center">
    <i class="fas fa-headset card-icon mb-3"></i>
    <h5>Help Section</h5>
    <p class="text-muted">Help & Support.</p>
    <!-- Redirect to Help.jsp -->
    <a href="Help.jsp" class="btn btn-custom">
      <i class="fas fa-arrow-right"></i> Go
    </a>
  </div>
</div>
    

  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

