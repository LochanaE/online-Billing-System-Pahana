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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add / Edit Customer - Pahana Edu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
  body { background-color: #F3F4F6; font-family: 'Segoe UI', sans-serif; color: #111827; }
  .card { border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); background-color: #ffffff; color: #111827; margin-bottom: 2rem; transition: 0.3s; }
  .card:hover { transform: translateY(-3px); box-shadow: 0 12px 28px rgba(0,0,0,0.15); }
  h3 { font-weight: 600; }
  .text-warning { color: #FACC15 !important; }
  .form-floating>.form-control:focus~label,
  .form-floating>.form-control:not(:placeholder-shown)~label { opacity: 0.9; font-size: 0.85rem; color: #2563EB; }
  .form-control { background-color: #F9FAFB; border: 1px solid #D1D5DB; color: #111827; transition: 0.3s; }
  .form-control:focus { border-color: #2563EB; box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.25); }
  .form-control::placeholder { color: transparent; }
  .btn-custom { background-color: #2563EB; color: #ffffff; font-weight: 600; transition: 0.3s; }
  .btn-custom:hover { background-color: #1E40AF; }
  .btn-primary { background-color: #10B981; border-color: #10B981; color: #ffffff; font-weight: 600; }
  .btn-primary:hover { background-color: #059669; }
  .table thead { background-color: #2563EB; color: #ffffff; }
  .table-hover tbody tr:hover { background-color: rgba(37, 99, 235, 0.1); color: #111827; }
  .toast-container { position: fixed; top: 1rem; left: 50%; transform: translateX(-50%); z-index: 1055; }
  .toast-success { background-color: #10B981; color: #ffffff; }
  .toast-danger { background-color: #DC2626; color: #ffffff; }
  .modal-content { border-radius: 12px; }
  @media(max-width:768px){ .text-end { text-align:center !important; } }
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

  <!-- Add Customer Card -->
  <div class="card p-4">
    <h3 class="text-center mb-4 text-warning"><i class="fas fa-user-plus"></i> Add Customer</h3>
    <form method="post" action="<%= request.getContextPath() %>/CustomerServlet">
      <input type="hidden" name="action" value="add" />
      <div class="row g-3">
        <div class="col-md-3 form-floating">
          <input name="accountNo" class="form-control" placeholder="Account No" required>
          <label>Account No</label>
        </div>
        <div class="col-md-3 form-floating">
          <input name="fullName" class="form-control" placeholder="Full Name" required>
          <label>Full Name</label>
        </div>
        <div class="col-md-3 form-floating">
          <input name="address" class="form-control" placeholder="Address" required>
          <label>Address</label>
        </div>
        <div class="col-md-3 form-floating">
          <input name="phone" class="form-control" placeholder="Phone" required>
          <label>Phone</label>
        </div>
      </div>
      <div class="mt-3 text-end">
        <button class="btn btn-primary"><i class="fas fa-save"></i> Save</button>
      </div>
    </form>
  </div>

  <!-- Customer List Card -->
  <div class="card p-4">
    <h3 class="mb-3 text-warning"><i class="fas fa-users"></i> Customer List</h3>
    <div class="table-responsive">
      <table class="table table-hover align-middle">
        <thead>
          <tr>
            <th>Account No</th>
            <th>Full Name</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="c" items="${customerList}">
            <tr>
              <td>${c.accountNo}</td>
              <td>${c.fullName}</td>
              <td>${c.address}</td>
              <td>${c.phone}</td>
              <td>
                <button type="button" class="btn btn-sm btn-custom editBtn"
                        data-account="${c.accountNo}"
                        data-name="${c.fullName}"
                        data-address="${c.address}"
                        data-phone="${c.phone}">
                  <i class="fas fa-edit"></i>
                </button>
                <button type="button" class="btn btn-sm btn-danger deleteBtn ms-2"
                        data-account="${c.accountNo}">
                  <i class="fas fa-trash"></i>
                </button>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

</div>

<!-- Hidden Delete Form -->
<form id="deleteForm" method="post" action="<%= request.getContextPath() %>/CustomerServlet" style="display:none;">
  <input type="hidden" name="action" value="delete" />
  <input type="hidden" name="accountNo" id="deleteAccount" />
</form>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <form method="post" action="<%= request.getContextPath() %>/CustomerServlet">
        <div class="modal-header">
          <h5 class="modal-title text-warning"><i class="fas fa-edit"></i> Edit Customer</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" name="action" value="update" />
          <div class="form-floating mb-2">
            <input type="text" name="accountNo" id="editAccount" class="form-control" placeholder="Account No" readonly>
            <label>Account No</label>
          </div>
          <div class="form-floating mb-2">
            <input type="text" name="fullName" id="editName" class="form-control" placeholder="Full Name" required>
            <label>Full Name</label>
          </div>
          <div class="form-floating mb-2">
            <input type="text" name="address" id="editAddress" class="form-control" placeholder="Address" required>
            <label>Address</label>
          </div>
          <div class="form-floating mb-2">
            <input type="text" name="phone" id="editPhone" class="form-control" placeholder="Phone" required>
            <label>Phone</label>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-warning">Save Changes</button>
        </div>
      </form>
    </div>
  </div>
</div>


<!-- Toast -->
<div class="toast-container">
<%
    // Flash object get
    com.PahanaOnlineBilling.util.FlashMessage.Flash flash =
        com.PahanaOnlineBilling.util.FlashMessage.getMessage(request);

    if (flash != null) {
%>
<div class="toast show toast-success" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="d-flex">
        <!--message text -->
        <div class="toast-body"><%= flash.getMessage() %></div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var toastElList = [].slice.call(document.querySelectorAll('.toast'));
    var toastList = toastElList.map(function (toastEl) {
        return new bootstrap.Toast(toastEl, { delay: 3000 }); // auto-hide 5 sec
    });
    toastList.forEach(toast => toast.show());
});
</script>
<%
    }
%>

   
  
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- <script>
    document.addEventListener('DOMContentLoaded', function () {
        var toastElList = [].slice.call(document.querySelectorAll('.toast'))
        var toastList = toastElList.map(function (toastEl) {
            return new bootstrap.Toast(toastEl, { delay: 5000 }) // auto-hide after 5 sec
        });
        toastList.forEach(toast => toast.show());
    });
</script> -->

<script>
  const editBtns = document.querySelectorAll(".editBtn");
  const editModal = new bootstrap.Modal(document.getElementById("editModal"));
  editBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      document.getElementById("editAccount").value = btn.dataset.account;
      document.getElementById("editName").value = btn.dataset.name;
      document.getElementById("editAddress").value = btn.dataset.address;
      document.getElementById("editPhone").value = btn.dataset.phone;
      editModal.show();
    });
  });

  const deleteBtns = document.querySelectorAll(".deleteBtn");
  deleteBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      if(confirm("Are you sure you want to delete this customer?")) {
        document.getElementById("deleteAccount").value = btn.dataset.account;
        document.getElementById("deleteForm").submit();
      }
    });
  });
  // Auto hide flash toast

</script>

</body>
</html>
