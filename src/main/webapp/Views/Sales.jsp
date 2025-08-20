<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="PahanaOnlineBilling.modal.User" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("Views/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Sales Report - Pahana Edu</title>
<script src="https://cdn.tailwindcss.com"></script>
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="h-full font-sans text-gray-900" x-data="{ filterText: '' }">

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

<!-- Main Content -->
<main class="flex flex-col items-center p-6">

  <!-- Heading + Search -->
  <div class="w-full max-w-5xl mb-6 flex flex-col md:flex-row justify-between items-center bg-white p-4 rounded-xl shadow-md">
    <h2 class="text-2xl font-semibold text-blue-600 flex items-center mb-3 md:mb-0">
      <i class="fas fa-chart-line mr-2"></i> Sales Report
    </h2>
    <input type="text" placeholder="Search Customer / Invoice #" class="border px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
           x-model="filterText">
  </div>

  <!-- Sales Table Card -->
  <div class="w-full max-w-5xl bg-white rounded-xl shadow-lg overflow-x-auto">
    <table class="table-auto w-full border border-gray-200">
      <thead class="bg-blue-600 text-white text-center">
        <tr>
          <th class="px-4 py-2 border">Invoice #</th>
          <th class="px-4 py-2 border">Customer</th>
          <th class="px-4 py-2 border">Date</th>
          <th class="px-4 py-2 border">Items</th>
          <th class="px-4 py-2 border">Total (Rs)</th>
        </tr>
      </thead>
      <tbody class="text-center">
        <!-- Fake Data -->
        <template x-for="order in [
          {billId:101, customerName:'John Doe', date:'2025-08-20', itemsSummary:'Book x2, Pen x5', totalAmount:1250},
          {billId:102, customerName:'Jane Smith', date:'2025-08-19', itemsSummary:'Notebook x3', totalAmount:900},
          {billId:103, customerName:'Ali Khan', date:'2025-08-18', itemsSummary:'Pen x10, Eraser x2', totalAmount:500},
          {billId:104, customerName:'Mary Jane', date:'2025-08-17', itemsSummary:'Book x1, Notebook x2', totalAmount:800}
        ]" :key="order.billId">
          <tr class="hover:bg-gray-100" x-show="filterText === '' || order.customerName.toLowerCase().includes(filterText.toLowerCase()) || order.billId.toString().includes(filterText)">
            <td class="px-4 py-2 border font-semibold">INV-<span x-text="order.billId"></span></td>
            <td class="px-4 py-2 border" x-text="order.customerName"></td>
            <td class="px-4 py-2 border" x-text="order.date"></td>
            <td class="px-4 py-2 border" x-text="order.itemsSummary"></td>
            <td class="px-4 py-2 border font-semibold text-green-600" x-text="'Rs ' + order.totalAmount"></td>
          </tr>
        </template>
      </tbody>
    </table>
  </div>

</main>

</body>
</html>
