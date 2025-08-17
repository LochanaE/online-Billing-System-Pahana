<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<title>Billing - Pahana Edu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
body {
    background-color: #F3F4F6;
    font-family: 'Segoe UI', sans-serif;
    color: #111827;
}
.navbar { box-shadow: 0 2px 12px rgba(0,0,0,0.1); }
.card {
    border-radius: 12px;
    box-shadow: 0 8px 24px rgba(0,0,0,0.05);
    background-color: #ffffff;
    transition: 0.3s;
}
.card:hover { transform: translateY(-2px); box-shadow: 0 12px 28px rgba(0,0,0,0.1); }
h3 { font-weight: 600; }
.btn-custom { background-color: #2563EB; color: #fff; }
.btn-custom:hover { background-color: #1E40AF; }
.form-control:focus { border-color: #2563EB; box-shadow: none; }
.table thead { background-color: #2563EB; color: #fff; }
.table tbody tr:hover { background-color: #f1f5f9; }
.invoice-preview {
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 8px 24px rgba(0,0,0,0.05);
    padding: 2rem;
}
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
  <div class="container-fluid">
    <a class="navbar-brand text-warning" href="<%= request.getContextPath() %>/Views/DashBoard.jsp">
      <i class="fas fa-book-open"></i> Pahana Edu
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link active" href="<%= request.getContextPath() %>/Views/DashBoard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container py-4">
  <div class="row g-4">
    <!-- Left Column: Invoice Form -->
    <div class="col-lg-6">
      <div class="card p-4">
        <h3 class="mb-4 text-center text-warning"><i class="fas fa-file-invoice"></i> Generate Invoice</h3>
        <form method="post" action="<%= request.getContextPath() %>/BillingServlet">
          <div class="mb-3">
            <label class="form-label fw-semibold">Select Customer</label>
            <select name="customerId" class="form-control form-control-lg">
              <c:forEach var="c" items="${customerList}">
                <option value="${c.customerId}">${c.fullName}</option>
              </c:forEach>
            </select>
          </div>

          <div class="table-responsive mb-4">
            <table class="table table-hover align-middle">
              <thead>
                <tr>
                  <th>Select</th>
                  <th>Item Name</th>
                  <th>Price</th>
                  <th>Qty</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="it" items="${itemList}">
                  <tr>
                    <td><input type="checkbox" name="itemIds" value="${it.itemId}"></td>
                    <td>${it.itemName}</td>
                    <td>$${it.price}</td>
                    <td><input type="number" name="qty_${it.itemId}" value="1" min="1" class="form-control" style="max-width:80px;"></td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>

          <div class="d-grid">
            <button type="submit" class="btn btn-custom btn-lg"><i class="fas fa-receipt"></i> Create Invoice</button>
          </div>
        </form>
      </div>
    </div>

<!-- Right Column: Invoice Preview -->
<div class="col-lg-6">
  <div class="invoice-preview">
    <c:if test="${not empty billItems}">
        <h4 class="text-center mb-4 text-primary"><i class="fas fa-file-invoice-dollar"></i> Invoice Preview</h4>
        <div class="mb-3"><strong>Invoice Number:</strong> INV-${billId}</div>
        <div class="mb-3"><strong>Billed To:</strong> ${customer.fullName}</div>

        <div class="table-responsive mb-3">
          <table class="table table-bordered">
            <thead class="table-primary">
              <tr>
                <th>#</th>
                <th>Item</th>
                <th>Qty</th>
                <th>Price</th>
                <th>Amount</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="it" items="${billItems}" varStatus="status">
                <tr>
                  <td>${status.index + 1}</td>
                  <td>${it.itemName}</td>
                  <td>${it.quantity}</td>
                  <td>$${it.price}</td>
                  <td>$${it.price * it.quantity}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <div class="text-end">
          <p>Sub Total: $<c:out value="${totalAmount}"/></p>
          <p>Tax (5%): $<c:out value="${totalAmount * 0.05}"/></p>
          <h5>Total: $<c:out value="${totalAmount * 1.05}"/></h5>
        </div>

        <div class="text-center">
          <button class="btn btn-success" onclick="window.print();">
            <i class="fas fa-print"></i> Print Bill
          </button>
        </div>
    </c:if>
    <c:if test="${empty billItems}">
        <p class="text-muted text-center">Invoice Preview will appear here after creating a bill.</p>
    </c:if>
  </div>
</div>




  </div>
</div>
<script>
document.addEventListener("DOMContentLoaded", function() {
    // Remove item row
    document.querySelectorAll(".remove-item").forEach(btn => {
        btn.addEventListener("click", function() {
            const row = this.closest("tr");
            row.remove();
            updateTotal();
        });
    });

    // Update total amount after removing items
    function updateTotal() {
        let total = 0;
        document.querySelectorAll("#invoiceTable tbody tr").forEach(row => {
            const qty = parseFloat(row.cells[2].innerText);
            const price = parseFloat(row.cells[3].innerText.replace('$',''));
            total += qty * price;
        });
        document.getElementById("totalAmount").innerText = total.toFixed(2);
    }

    // Print invoice
    document.getElementById("printInvoice").addEventListener("click", function() {
        const printContents = document.querySelector(".invoice-preview").innerHTML;
        const originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;
        window.print();
        document.body.innerHTML = originalContents;
        location.reload(); // reload to restore original page
    });
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
