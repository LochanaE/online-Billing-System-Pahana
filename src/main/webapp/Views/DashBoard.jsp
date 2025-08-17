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
    <a class="navbar-brand text-warning" href="DashBoard.jsp">
      <i class="fas fa-book-open"></i> Pahana Edu
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link active" href="#"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
      </ul>
    </div>
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
    <i class="fas fa-book card-icon mb-3"></i>
    <h5>Manage Books</h5>
    <p class="text-muted">Add, view, edit, or delete books in your store.</p>
    <a href="<%= request.getContextPath() %>/BookServlet" class="btn btn-custom">
      <i class="fas fa-arrow-right"></i> Go
    </a>
  </div>
</div>
    

    <!-- Reports Card -->
    <div class="col-md-4">
      <div class="card p-4 text-center">
        <i class="fas fa-chart-line card-icon mb-3"></i>
        <h5>Reports</h5>
        <p class="text-muted">Generate billing and usage reports.</p>
        <a href="#" class="btn btn-custom"><i class="fas fa-arrow-right"></i> Go</a>
      </div>
    </div>

    <!-- Payments Card -->
    <div class="col-md-4">
      <div class="card p-4 text-center">
        <i class="fas fa-credit-card card-icon mb-3"></i>
        <h5>Payments</h5>
        <p class="text-muted">Manage customer payments securely.</p>
        <a href="#" class="btn btn-custom"><i class="fas fa-arrow-right"></i> Go</a>
      </div>
    </div>

    <!-- Settings Card -->
    <div class="col-md-4">
      <div class="card p-4 text-center">
        <i class="fas fa-cogs card-icon mb-3"></i>
        <h5>Settings</h5>
        <p class="text-muted">Configure system preferences and options.</p>
        <a href="#" class="btn btn-custom"><i class="fas fa-arrow-right"></i> Go</a>
      </div>
    </div>

  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

