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
<script src="https://cdn.tailwindcss.com"></script>
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body class="h-full font-sans text-gray-900" x-data="{ modalOpen: false, invoiceModalOpen: ${not empty billItems} }">

<!-- Navbar -->
<nav class="bg-white shadow-md h-16 flex items-center justify-between px-6 mb-6">
  <div class="flex items-center space-x-4">
    <a href="<%= request.getContextPath() %>/Views/DashBoard.jsp" class="text-yellow-500 font-bold text-xl flex items-center">
      <i class="fas fa-book-open mr-2"></i> Pahana Edu
    </a>
    <a href="<%= request.getContextPath() %>/Views/DashBoard.jsp" class="text-blue-600 font-semibold flex items-center">
      <i class="fas fa-tachometer-alt mr-1"></i> Dashboard
    </a>
    <a href="<%= request.getContextPath() %>/CustomerServlet?action=addPage" class="text-green-600 font-semibold flex items-center hover:text-green-800 transition">
      <i class="fas fa-user-plus mr-1"></i> Add Customer
    </a>
  </div>
  <ul class="flex items-center space-x-4">
    <li class="flex items-center space-x-2">
      <%
          String fillColor = "0d6efd"; 
          if ("Admin".equalsIgnoreCase(user.getRole())) fillColor = "ffc107";
      %>
      <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" viewBox="0 0 24 24" class="rounded-full bg-gray-100">
        <path fill="#<%= fillColor %>" d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
      </svg>
      <span class="font-semibold text-gray-800"><%= user.getUsername() %><small class="text-gray-500">(<%= user.getRole() %>)</small></span>
    </li>
    <li>
      <a href="<%= request.getContextPath() %>/LogoutServlet" class="text-red-600 hover:text-red-800 flex items-center">
        <i class="fas fa-sign-out-alt mr-1"></i> Logout
      </a>
    </li>
  </ul>
</nav>

<main class="flex flex-col items-center p-6">

  <!-- Generate Invoice Button -->
  <div class="mb-4" x-show="!modalOpen && !invoiceModalOpen">
    <button @click="modalOpen = true" class="py-2 px-4 rounded bg-blue-600 text-white hover:bg-blue-700 transition flex items-center">
      <i class="fas fa-file-invoice mr-2"></i> Generate Invoice
    </button>
  </div>

  <!-- Generate Invoice Modal -->
  <div x-show="modalOpen" class="fixed inset-0 flex items-center justify-center z-50 bg-black bg-opacity-50">
    <div @click.away="modalOpen=false" class="bg-white rounded-xl shadow-lg w-11/12 md:w-2/3 lg:w-1/2 p-6 overflow-auto max-h-[90vh]">
      <div class="flex justify-between items-center mb-4">
        <h3 class="text-lg font-semibold text-blue-600"><i class="fas fa-file-invoice mr-2"></i> Generate Invoice</h3>
        <button @click="modalOpen=false" class="text-gray-600 hover:text-gray-800"><i class="fas fa-times"></i></button>
      </div>
      <form method="post" action="<%= request.getContextPath() %>/BillingServlet">
        <div class="mb-4">
          <label class="block font-medium mb-1">Select Customer</label>
          <select name="customerId" class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
            <c:forEach var="c" items="${customerList}">
              <option value="${c.customerId}">${c.fullName}</option>
            </c:forEach>
          </select>
        </div>
        <div class="overflow-x-auto mb-4">
          <table class="w-full table-auto border border-gray-200">
            <thead class="bg-blue-600 text-white">
              <tr>
                <th class="px-2 py-1 border">Select</th>
                <th class="px-2 py-1 border">Item Name</th>
                <th class="px-2 py-1 border">Price (Rs)</th>
                <th class="px-2 py-1 border">Qty</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="it" items="${itemList}">
                <tr class="hover:bg-gray-100">
                  <td class="px-2 py-1 border text-center"><input type="checkbox" name="itemIds" value="${it.itemId}"></td>
                  <td class="px-2 py-1 border">${it.itemName}</td>
                  <td class="px-2 py-1 border">Rs ${it.price}</td>
                  <td class="px-2 py-1 border"><input type="number" name="qty_${it.itemId}" value="1" min="1" class="w-20 border rounded px-1 py-1"></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        <div class="flex justify-end">
          <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition">
            <i class="fas fa-receipt mr-2"></i> Create Invoice
          </button>
        </div>
      </form>
    </div>
  </div>

  <!-- Invoice Preview Modal -->
  <div x-show="invoiceModalOpen" class="fixed inset-0 flex items-center justify-center z-50 bg-black bg-opacity-50">
    <div @click.away="invoiceModalOpen=false" class="bg-white rounded-xl shadow-lg w-11/12 md:w-2/3 lg:w-1/2 p-6 overflow-auto max-h-[90vh]">
      <div class="flex justify-between items-center mb-4">
        <h3 class="text-lg font-semibold text-blue-600"><i class="fas fa-file-invoice mr-2"></i> Invoice Preview</h3>
        <button @click="invoiceModalOpen=false" class="text-gray-600 hover:text-gray-800"><i class="fas fa-times"></i></button>
      </div>
      <c:if test="${not empty billItems}">
        <div class="overflow-x-auto mb-3">
          <table class="table-auto w-full border border-gray-200 text-center">
            <thead class="bg-blue-600 text-white">
              <tr>
                <th class="px-2 py-1 border">#</th>
                <th class="px-2 py-1 border">Item</th>
                <th class="px-2 py-1 border">Qty</th>
                <th class="px-2 py-1 border">Price (Rs)</th>
                <th class="px-2 py-1 border">Amount (Rs)</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="it" items="${billItems}" varStatus="status">
                <tr class="hover:bg-gray-100">
                  <td class="px-2 py-1 border">${status.index + 1}</td>
                  <td class="px-2 py-1 border">${it.itemName}</td>
                  <td class="px-2 py-1 border">${it.quantity}</td>
                  <td class="px-2 py-1 border">Rs ${it.price}</td>
                  <td class="px-2 py-1 border">Rs ${it.price * it.quantity}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        <div class="text-right mb-4">
          <p>Sub Total: Rs <c:out value="${totalAmount}"/></p>
          <p>Tax (5%): Rs <c:out value="${totalAmount * 0.05}"/></p>
          <h5 class="font-semibold">Total: Rs <c:out value="${totalAmount * 1.05}"/></h5>
        </div>
        <div class="flex justify-center space-x-4">
          <button class="bg-green-600 text-white py-2 px-4 rounded hover:bg-green-700 transition" 
                  onclick="printAndRedirect()">
            <i class="fas fa-print mr-2"></i> Print Bill
          </button>
          <button class="bg-gray-400 text-white py-2 px-4 rounded hover:bg-gray-500 transition" 
                  @click="invoiceModalOpen=false">
            <i class="fas fa-times mr-2"></i> Cancel
          </button>
        </div>
      </c:if>
    </div>
  </div>

</main>

<script>
toastr.options = {
  "closeButton": false,
  "progressBar": true,
  "positionClass": "toast-top-right",
  "timeOut": "3000"
};

function printAndRedirect() {
  window.print();
  window.location.href = '<%= request.getContextPath() %>/BillingServlet';
}
</script>

</body>
</html>


<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<!-- Alpine.js -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Toastr -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body class="h-full font-sans text-gray-900" x-data="{ modalOpen: false }">

<!-- Top Navbar -->
<nav class="bg-white shadow-md h-16 flex items-center justify-between px-6 mb-6">
  <div class="flex items-center space-x-4">
    <a href="<%= request.getContextPath() %>/Views/DashBoard.jsp" class="text-yellow-500 font-bold text-xl flex items-center">
      <i class="fas fa-book-open mr-2"></i> Pahana Edu
    </a>
    <a href="<%= request.getContextPath() %>/Views/DashBoard.jsp" class="text-blue-600 font-semibold flex items-center">
      <i class="fas fa-tachometer-alt mr-1"></i> Dashboard
    </a>
    <a href="<%= request.getContextPath() %>/CustomerServlet?action=addPage" class="text-green-600 font-semibold flex items-center hover:text-green-800 transition">
      <i class="fas fa-user-plus mr-1"></i> Add Customer
    </a>
  </div>

  <ul class="flex items-center space-x-4">
    <li class="flex items-center space-x-2">
      <%
          String fillColor = "0d6efd";
          if ("Admin".equalsIgnoreCase(user.getRole())) {
              fillColor = "ffc107";
          }
      %>
      <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" viewBox="0 0 24 24" class="rounded-full bg-gray-100">
        <path fill="#<%= fillColor %>" d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
      </svg>
      <span class="font-semibold text-gray-800">
        <%= user.getUsername() %>
        <small class="text-gray-500">(<%= user.getRole() %>)</small>
      </span>
    </li>
    <li>
      <a href="<%= request.getContextPath() %>/LogoutServlet" class="text-red-600 hover:text-red-800 flex items-center">
        <i class="fas fa-sign-out-alt mr-1"></i> Logout
      </a>
    </li>
  </ul>
</nav>

<!-- Main Content -->
<main class="flex justify-center p-6">
  <div class="w-full max-w-5xl">
    <!-- Centered Generate Invoice Button -->
    <div class="flex justify-center mb-4">
      <button @click="modalOpen = true" class="py-2 px-3 rounded bg-blue-600 text-white hover:bg-blue-700 transition flex items-center">
        <i class="fas fa-file-invoice mr-2"></i> Generate Invoice
      </button>
    </div>

    <div class="grid md:grid-cols-1 gap-6">
      <!-- Invoice Preview -->
      <div class="bg-white p-6 rounded-xl shadow-lg invoice-preview">
        <c:if test="${not empty billItems}">
          <h4 class="text-center mb-4 text-blue-600 text-lg font-semibold">
            <i class="fas fa-file-invoice-dollar mr-2"></i> Invoice Preview
          </h4>
          <div class="mb-3"><strong>Invoice Number:</strong> INV-${billId}</div>
          <div class="mb-3"><strong>Billed To:</strong> ${customer.fullName}</div>

          <div class="overflow-x-auto mb-3">
            <table class="table-auto w-full border border-gray-200 text-center">
              <thead class="bg-blue-600 text-white">
                <tr>
                  <th class="px-2 py-1 border">#</th>
                  <th class="px-2 py-1 border">Item</th>
                  <th class="px-2 py-1 border">Qty</th>
                  <th class="px-2 py-1 border">Price (Rs)</th>
                  <th class="px-2 py-1 border">Amount (Rs)</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="it" items="${billItems}" varStatus="status">
                  <tr class="hover:bg-gray-100">
                    <td class="px-2 py-1 border">${status.index + 1}</td>
                    <td class="px-2 py-1 border">${it.itemName}</td>
                    <td class="px-2 py-1 border">${it.quantity}</td>
                    <td class="px-2 py-1 border">Rs ${it.price}</td>
                    <td class="px-2 py-1 border">Rs ${it.price * it.quantity}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>

          <div class="text-right">
            <p>Sub Total: Rs <c:out value="${totalAmount}"/></p>
            <p>Tax (5%): Rs <c:out value="${totalAmount * 0.05}"/></p>
            <h5 class="font-semibold">Total: Rs <c:out value="${totalAmount * 1.05}"/></h5>
          </div>

          <div class="text-center mt-4 flex justify-center space-x-4">
            <button class="bg-green-600 text-white py-2 px-4 rounded hover:bg-green-700 transition" onclick="window.print();">
              <i class="fas fa-print mr-2"></i> Print Bill
            </button>
            <button class="bg-gray-400 text-white py-2 px-4 rounded hover:bg-gray-500 transition" onclick="window.location.reload();">
              <i class="fas fa-times mr-2"></i> Cancel
            </button>
          </div>
        </c:if>
        <c:if test="${empty billItems}">
          <p class="text-gray-500 text-center">Invoice Preview will appear here after creating a bill.</p>
        </c:if>
      </div>
    </div>
  </div>
</main>

<!-- Modal for Generate Invoice -->
<div x-show="modalOpen" class="fixed inset-0 flex items-center justify-center z-50 bg-black bg-opacity-50">
  <div @click.away="modalOpen=false" class="bg-white rounded-xl shadow-lg w-11/12 md:w-2/3 lg:w-1/2 p-6">
    <div class="flex justify-between items-center mb-4">
      <h3 class="text-lg font-semibold text-blue-600"><i class="fas fa-file-invoice mr-2"></i> Generate Invoice</h3>
      <button @click="modalOpen=false" class="text-gray-600 hover:text-gray-800"><i class="fas fa-times"></i></button>
    </div>
    <form method="post" action="<%= request.getContextPath() %>/BillingServlet">
      <div class="mb-4">
        <label class="block font-medium mb-1">Select Customer</label>
        <select name="customerId" class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
          <c:forEach var="c" items="${customerList}">
            <option value="${c.customerId}">${c.fullName}</option>
          </c:forEach>
        </select>
      </div>

      <div class="overflow-x-auto mb-4">
        <table class="w-full table-auto border border-gray-200">
          <thead class="bg-blue-600 text-white">
            <tr>
              <th class="px-2 py-1 border">Select</th>
              <th class="px-2 py-1 border">Item Name</th>
              <th class="px-2 py-1 border">Price</th>
              <th class="px-2 py-1 border">Qty</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="it" items="${itemList}">
              <tr class="hover:bg-gray-100">
                <td class="px-2 py-1 border text-center"><input type="checkbox" name="itemIds" value="${it.itemId}"></td>
                <td class="px-2 py-1 border">${it.itemName}</td>
                <td class="px-2 py-1 border">Rs ${it.price}</td>
                <td class="px-2 py-1 border"><input type="number" name="qty_${it.itemId}" value="1" min="1" class="w-20 border rounded px-1 py-1"></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <div class="flex justify-end space-x-2">
        <button type="button" @click="modalOpen=false" class="bg-gray-400 text-white px-4 py-2 rounded hover:bg-gray-500 transition">
          <i class="fas fa-times mr-2"></i> Cancel
        </button>
        <button type="submit" @click="toastr.success('Invoice Created Successfully');" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition">
          <i class="fas fa-receipt mr-2"></i> Create Invoice
        </button>
      </div>
    </form>
  </div>
</div>

<script>
toastr.options = {
  "closeButton": false,
  "progressBar": true,
  "positionClass": "toast-top-right",
  "timeOut": "3000"
};
</script>

</body>
</html>
 --%>