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
<title>Manage Items - Pahana Edu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
  body { background-color: #F3F4F6; font-family: 'Segoe UI', sans-serif; color: #111827; }
  .card { border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); background-color: #ffffff; color: #111827; margin-bottom: 2rem; transition: 0.3s; }
  .card:hover { transform: translateY(-3px); box-shadow: 0 12px 28px rgba(0,0,0,0.15); }
  h3 { font-weight: 600; }
  .text-warning { color: #FACC15 !important; }
  .form-control { background-color: #F9FAFB; border: 1px solid #D1D5DB; color: #111827; transition: 0.3s; }
  .form-control:focus { border-color: #2563EB; box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.25); }
  .form-floating>label { color: #6B7280; transition: 0.3s; }
  .form-floating>.form-control:focus~label,
  .form-floating>.form-control:not(:placeholder-shown)~label { color: #2563EB; font-weight: 500; }
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
  @media(max-width:768px){ .text-end { text-align:center !important; } 
  .form-control-lg {
  font-size: 1.1rem;
  padding: 1.3rem 1rem; /* වැඩි height */
  border-radius: 12px;
  transition: 0.3s;
}

.form-control-lg:focus {
  border-color: #2563EB;
  box-shadow: 0 0 10px rgba(37, 99, 235, 0.3);
}

.shadow-sm {
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.btn-lg {
  font-size: 1.1rem;
  padding: 0.9rem 2rem;
  border-radius: 10px;
  font-weight: 600;
}
  
  }
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm mb-4">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    
    <!-- Brand + Dashboard group -->
    <div class="d-flex align-items-center">
      <a class="navbar-brand text-warning" href="<%= request.getContextPath() %>/Views/DashBoard.jsp">
        <i class="fas fa-book-open"></i> Pahana Edu
      </a>
      <a class="nav-link text-primary ms-3 fw-semibold" href="<%= request.getContextPath() %>/Views/DashBoard.jsp">
        <i class="fas fa-tachometer-alt"></i> Dashboard
      </a>
    </div>

    <!-- Right side items -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="<%= request.getContextPath() %>/LogoutServlet">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </li>
    </ul>
  </div>
</nav>


<div class="container py-4">

  
<!-- Add Item Card -->
<div class="card p-5 mb-4 shadow-sm">
  <h3 class="text-center mb-4 text-warning"><i class="fas fa-box"></i> Add Item</h3>
  <form method="post" action="<%= request.getContextPath() %>/ItemServlet">
    <input type="hidden" name="action" value="add" />
    
    <!-- First Row: Item Name, Category, Supplier -->
    <div class="row g-4 mb-3">
      <div class="col-md-4">
        <div class="form-floating">
          <input name="itemName" class="form-control form-control-lg shadow-sm" placeholder="Item Name" required>
          <label>Item Name</label>
        </div>
      </div>
      <div class="col-md-4">
        <div class="form-floating">
          <input name="category" class="form-control form-control-lg shadow-sm" placeholder="Category" required>
          <label>Category</label>
        </div>
      </div>
      <div class="col-md-4">
        <div class="form-floating">
          <input name="supplier" class="form-control form-control-lg shadow-sm" placeholder="Supplier" required>
          <label>Supplier</label>
        </div>
      </div>
    </div>
    
    <!-- Second Row: Price, Quantity -->
    <div class="row g-4 mb-3">
      <div class="col-md-2">
        <div class="form-floating">
          <input name="price" type="number" step="0.01" class="form-control form-control-lg shadow-sm" placeholder="Price" required>
          <label>Price</label>
        </div>
      </div>
      <div class="col-md-2">
        <div class="form-floating">
          <input name="quantity" type="number" class="form-control form-control-lg shadow-sm" placeholder="Quantity" required>
          <label>Quantity</label>
        </div>
      </div>
    </div>

    <div class="mt-3 text-end">
      <button class="btn btn-primary"><i class="fas fa-save"></i> Save</button>
    </div>
    
  </form>
</div>


  <!-- Search & Item List Card -->
  <div class="card p-4">
    <h3 class="mb-3 text-warning"><i class="fas fa-list"></i> Item List</h3>
    <div class="input-group mb-3">
      <input type="text" id="searchInput" name="search" class="form-control" placeholder="Search by Name, Category, Supplier">
      <button class="btn btn-custom" id="searchBtn"><i class="fas fa-search"></i> Search</button>
    </div>

    <div class="table-responsive">
      <table class="table table-hover align-middle" id="itemTable">
        <thead>
          <tr>
            <th>Item ID</th>
            <th>Item Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Supplier</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="item" items="${itemList}">
            <tr>
              <td>${item.itemId}</td>
              <td>${item.itemName}</td>
              <td>${item.category}</td>
              <td>${item.price}</td>
              <td>${item.quantity}</td>
              <td>${item.supplier}</td>
              <td>
                <button type="button" class="btn btn-sm btn-custom editBtn"
                        data-itemid="${item.itemId}"
                        data-name="${item.itemName}"
                        data-category="${item.category}"
                        data-price="${item.price}"
                        data-quantity="${item.quantity}"
                        data-supplier="${item.supplier}">
                  <i class="fas fa-edit"></i>
                </button>
                <button type="button" class="btn btn-sm btn-danger deleteBtn ms-2"
                        data-itemid="${item.itemId}">
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
<form id="deleteForm" method="post" action="<%= request.getContextPath() %>/ItemServlet" style="display:none;">
  <input type="hidden" name="action" value="delete" />
  <input type="hidden" name="itemId" id="deleteItemId" />
</form>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <form method="post" action="<%= request.getContextPath() %>/ItemServlet">
        <div class="modal-header">
          <h5 class="modal-title text-warning"><i class="fas fa-edit"></i> Edit Item</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" name="action" value="update" />
          <input type="hidden" name="itemId" id="editId" />
          
          <div class="form-floating mb-2">
            <input type="text" name="itemName" id="editName" class="form-control" placeholder="Item Name" required>
            <label>Item Name</label>
          </div>
          <div class="form-floating mb-2">
            <input type="text" name="category" id="editCategory" class="form-control" placeholder="Category" required>
            <label>Category</label>
          </div>
          <div class="form-floating mb-2">
            <input type="number" step="0.01" name="price" id="editPrice" class="form-control" placeholder="Price" required>
            <label>Price</label>
          </div>
          <div class="form-floating mb-2">
            <input type="number" name="quantity" id="editQuantity" class="form-control" placeholder="Quantity" required>
            <label>Quantity</label>
          </div>
          <div class="form-floating mb-2">
            <input type="text" name="supplier" id="editSupplier" class="form-control" placeholder="Supplier" required>
            <label>Supplier</label>
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
   com.PahanaOnlineBilling.util.FlashMessage.Flash flash = 
     com.PahanaOnlineBilling.util.FlashMessage.getMessage(request);
   if (flash != null) {
       String cls = ("danger".equalsIgnoreCase(flash.getType()) ? "toast-danger" : "toast-success");
%>
  <div class="toast show <%= cls %>" role="alert" aria-live="assertive">
    <div class="d-flex">
      <div class="toast-body"><%= flash.getMessage() %></div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
    </div>
  </div>
<%
   }
%>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const editBtns = document.querySelectorAll(".editBtn");
  const editModal = new bootstrap.Modal(document.getElementById("editModal"));
  editBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      document.getElementById("editId").value = btn.dataset.itemid; 
     
      document.getElementById("editName").value = btn.dataset.name;
      document.getElementById("editCategory").value = btn.dataset.category;
      document.getElementById("editPrice").value = btn.dataset.price;
      document.getElementById("editQuantity").value = btn.dataset.quantity;
      document.getElementById("editSupplier").value = btn.dataset.supplier;
      editModal.show();
    });
  });

  const deleteBtns = document.querySelectorAll(".deleteBtn");
  deleteBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      if(confirm("Are you sure you want to delete this item?")) {
        document.getElementById("deleteItemId").value = btn.dataset.itemid;
        document.getElementById("deleteForm").submit();
      }
    });
  });

  // Search / Cancel button functionality
  const searchInput = document.getElementById("searchInput");
  const searchBtn = document.getElementById("searchBtn");
  let searchActive = false;

  searchBtn.addEventListener("click", (e) => {
    e.preventDefault();
    if(!searchActive){
      const filter = searchInput.value.toLowerCase();
      const rows = document.querySelectorAll("#itemTable tbody tr");
      rows.forEach(row => {
        const cells = row.querySelectorAll("td");
        const match = Array.from(cells).some(td => td.textContent.toLowerCase().includes(filter));
        row.style.display = match ? "" : "none";
      });
      searchBtn.innerHTML = '<i class="fas fa-times"></i> Cancel';
      searchActive = true;
    } else {
      const rows = document.querySelectorAll("#itemTable tbody tr");
      rows.forEach(row => row.style.display = "");
      searchInput.value = "";
      searchBtn.innerHTML = '<i class="fas fa-search"></i> Search';
      searchActive = false;
    }
    document.querySelectorAll('.toast').forEach(toastEl => {
        const t = new bootstrap.Toast(toastEl, { delay: 3000 });
        t.show();
      });
  });
</script>

</body>
</html>
