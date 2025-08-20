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
<html lang="en" x-data="{ sidebarOpen: false, modalOpen: false }" class="h-full bg-gray-100">
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
<body class="h-full font-sans text-gray-900">

<!-- Sidebar -->
<div class="flex h-screen overflow-hidden">
  <div :class="sidebarOpen ? 'translate-x-0' : '-translate-x-full'" class="fixed z-30 inset-y-0 left-0 w-64 transition duration-300 transform bg-white shadow-lg md:relative md:translate-x-0">
    <div class="flex items-center justify-center h-16 shadow-md">
      <a href="<%= request.getContextPath() %>/Views/DashBoard.jsp" class="text-yellow-500 font-bold text-xl flex items-center"><i class="fas fa-book-open mr-2"></i> Pahana Edu</a>
    </div>
    <nav class="mt-5 px-4">
    <a class="nav-link text-primary ms-3 fw-semibold" href="<%= request.getContextPath() %>/Views/DashBoard.jsp">
        <i class="fas fa-tachometer-alt"></i> Dashboard
      </a>

      <button @click="modalOpen = true" 
        class="mt-4 w-full py-2 px-2 rounded bg-blue-600 text-white hover:bg-blue-700 transition">
  <i class="fas fa-file-invoice mr-2"></i> Generate Invoice
</button>

<!-- Add space between buttons -->
<div class="my-4"></div>

<button onclick="window.location.href='<%= request.getContextPath() %>/CustomerServlet?action=addPage'" 
        class="mt-4 w-full py-2 px-2 rounded bg-green-600 text-white hover:bg-green-700 transition">
  <i class="fas fa-user-plus mr-2"></i> Add Customer
</button>

      
    </nav>
  </div>

  <!-- Main content -->
  <div class="flex-1 flex flex-col overflow-auto">
    <!-- Navbar -->
    <header class="flex items-center justify-between bg-white shadow-md h-16 px-4">
      <button @click="sidebarOpen = !sidebarOpen" class="md:hidden text-gray-700 focus:outline-none">
        <i class="fas fa-bars"></i>
      </button>
      <h1 class="text-xl font-semibold">Manage Your Bill Here</h1>
    </header>

    <!-- Content -->
    <main class="flex-1 p-6">
      <div class="grid md:grid-cols-2 gap-6">

        <!-- Invoice Preview -->
        <div class="bg-white p-6 rounded-xl shadow-lg invoice-preview">
          <c:if test="${not empty billItems}">
            <h4 class="text-center mb-4 text-blue-600 text-lg font-semibold"><i class="fas fa-file-invoice-dollar mr-2"></i> Invoice Preview</h4>
            <div class="mb-3"><strong>Invoice Number:</strong> INV-${billId}</div>
            <div class="mb-3"><strong>Billed To:</strong> ${customer.fullName}</div>

            <div class="overflow-x-auto mb-3">
              <table class="table-auto w-full border border-gray-200">
                <thead class="bg-blue-600 text-white">
                  <tr>
                    <th class="px-2 py-1 border">#</th>
                    <th class="px-2 py-1 border">Item</th>
                    <th class="px-2 py-1 border">Qty</th>
                    <th class="px-2 py-1 border">Price</th>
                    <th class="px-2 py-1 border">Amount</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="it" items="${billItems}" varStatus="status">
                    <tr class="hover:bg-gray-100">
                      <td class="px-2 py-1 border">${status.index + 1}</td>
                      <td class="px-2 py-1 border">${it.itemName}</td>
                      <td class="px-2 py-1 border">${it.quantity}</td>
                      <td class="px-2 py-1 border">$${it.price}</td>
                      <td class="px-2 py-1 border">$${it.price * it.quantity}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>

            <div class="text-right">
              <p>Sub Total: $<c:out value="${totalAmount}"/></p>
              <p>Tax (5%): $<c:out value="${totalAmount * 0.05}"/></p>
              <h5 class="font-semibold">Total: $<c:out value="${totalAmount * 1.05}"/></h5>
            </div>

            <div class="text-center mt-4">
              <button class="bg-green-600 text-white py-2 px-4 rounded hover:bg-green-700 transition" onclick="window.print();">
                <i class="fas fa-print mr-2"></i> Print Bill
              </button>
            </div>
          </c:if>
          <c:if test="${empty billItems}">
            <p class="text-gray-500 text-center">Invoice Preview will appear here after creating a bill.</p>
          </c:if>
        </div>
      </div>
    </main>
  </div>
</div>

<!-- Modal -->
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
                <td class="px-2 py-1 border">$${it.price}</td>
                <td class="px-2 py-1 border"><input type="number" name="qty_${it.itemId}" value="1" min="1" class="w-20 border rounded px-1 py-1"></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <div class="flex justify-end">
        <button type="submit" @click="modalOpen=false; toastr.success('Invoice Created Successfully');" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition"><i class="fas fa-receipt mr-2"></i> Create Invoice</button>
      </div>
    </form>
  </div>
</div>

<script>
// Tailwind modal animation fix
document.addEventListener('alpine:init', () => {
    Alpine.data('modal', () => ({
        open: false
    }))
});

// Toastr options
toastr.options = {
  "closeButton": false,
  "progressBar": true,
  "positionClass": "toast-top-right",
  "timeOut": "3000"
};
</script>

</body>
</html>
