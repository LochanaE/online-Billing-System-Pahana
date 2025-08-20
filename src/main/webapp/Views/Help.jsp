<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="PahanaOnlineBilling.modal.User" %>
<%
    // Session check
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("Views/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en" x-data="{ openFaq: null }" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>Help & Support - POS System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap JS -->

<!-- Bootstrap 5 JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">


<!-- FontAwesome (if not included yet) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Alpine.js -->
    <script src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Toastr -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body class="bg-gray-100 font-sans">

<!-- Top Navigation -->
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
<div class="max-w-4xl mx-auto mt-8 p-6 bg-white rounded-2xl shadow-lg">

    <!-- FAQs -->
    <h2 class="text-xl font-bold mb-4">Frequently Asked Questions</h2>
    <div class="space-y-3">
        <!-- FAQ 1 -->
        <div class="border rounded-lg">
            <button class="w-full px-4 py-3 flex justify-between items-center"
                    @click="openFaq === 1 ? openFaq = null : openFaq = 1">
                <span class="font-semibold">How to create a new bill?</span>
                <i class="fas" :class="openFaq === 1 ? 'fa-chevron-up' : 'fa-chevron-down'"></i>
            </button>
            <div x-show="openFaq === 1" class="px-4 pb-4 text-gray-600">
                Go to the Billing section → Select customer → Add items → Click Generate Bill.
            </div>
        </div>

        <!-- FAQ 2 -->
        <div class="border rounded-lg">
            <button class="w-full px-4 py-3 flex justify-between items-center"
                    @click="openFaq === 2 ? openFaq = null : openFaq = 2">
                <span class="font-semibold">Can I edit a bill after generating it?</span>
                <i class="fas" :class="openFaq === 2 ? 'fa-chevron-up' : 'fa-chevron-down'"></i>
            </button>
            <div x-show="openFaq === 2" class="px-4 pb-4 text-gray-600">
                No, bills cannot be edited after generation. Instead, you can cancel/void a bill and create a new one.
            </div>
        </div>

        <!-- FAQ 3 -->
        <div class="border rounded-lg">
            <button class="w-full px-4 py-3 flex justify-between items-center"
                    @click="openFaq === 3 ? openFaq = null : openFaq = 3">
                <span class="font-semibold">How to add new items to the system?</span>
                <i class="fas" :class="openFaq === 3 ? 'fa-chevron-up' : 'fa-chevron-down'"></i>
            </button>
            <div x-show="openFaq === 3" class="px-4 pb-4 text-gray-600">
                Navigate to Items → Click Add Item → Fill details → Save.
            </div>
        </div>
    </div>

    <!-- Contact Section -->
    <h2 class="text-xl font-bold mt-8 mb-4">Need More Help?</h2>
    <div class="space-y-3">
        <!-- button onclick="toastr.success('Support request sent via Email!')"
                class="w-full bg-blue-600 text-white py-3 rounded-lg shadow hover:bg-blue-700">
            <i class="fas fa-envelope"></i> Contact via Email
        </button> -->
        <!-- Email Button -->
    <button onclick="window.location.href='https://www.posnation.com/support';"
            class="w-full bg-blue-600 text-white py-3 rounded-lg shadow hover:bg-blue-700">
        <i class="fas fa-envelope"></i> Contact via Email
    </button>

        <button type="button" class="w-full bg-green-600 text-white py-3 rounded-lg shadow hover:bg-green-700"
        data-bs-toggle="modal" data-bs-target="#supportModal">
    <i class="fas fa-phone"></i> Call Support
</button>

        <button type="button" class="btn btn-warning w-full py-3 rounded-lg shadow hover:bg-yellow-600"
        data-bs-toggle="modal" data-bs-target="#liveChartModal">
    <i class="fas fa-chart-line"></i> Live Chart
</button>
    </div>

</div>

<!-- Support Modal -->
<div class="modal fade" id="supportModal" tabindex="-1" aria-labelledby="supportModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content" style="font-family: 'Poppins', sans-serif;">
      
      <!-- Modal Header -->
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title" id="supportModalLabel"><i class="fas fa-phone"></i> Support Team</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body">
        <!-- Company Info with Icon -->
        <div class="d-flex align-items-center mb-4">
          <div class="bg-success text-white rounded-circle d-flex justify-content-center align-items-center shadow-sm"
               style="width:70px; height:70px; font-size: 32px;">
            <i class="fas fa-building-columns"></i>
          </div>
          <div class="ms-3">
            <h4 class="mb-1 fw-bold">EduTech Pvt Ltd</h4>
            <p class="mb-0 text-muted">Leading provider of innovative business technology solutions, delivering high-quality support to our clients.</p>
          </div>
        </div>

        <hr>

        <!-- Support Staff List -->
        <div class="row g-3">
          <div class="col-md-6">
            <div class="card p-3 shadow-sm">
              <h6 class="mb-1 fw-semibold">Tinel Pannala</h6>
              <p class="mb-0 text-muted"><i class="fas fa-phone me-1"></i> +94 77 123 4567</p>
            </div>
          </div>
          <div class="col-md-6">
            <div class="card p-3 shadow-sm">
              <h6 class="mb-1 fw-semibold">Shehani Kahadawala</h6>
              <p class="mb-0 text-muted"><i class="fas fa-phone me-1"></i> +94 71 234 5678</p>
            </div>
          </div>
          <div class="col-md-6">
            <div class="card p-3 shadow-sm">
              <h6 class="mb-1 fw-semibold">Piumi Hansamali</h6>
              <p class="mb-0 text-muted"><i class="fas fa-phone me-1"></i> +94 76 345 6789</p>
            </div>
          </div>
          <div class="col-md-6">
            <div class="card p-3 shadow-sm">
              <h6 class="mb-1 fw-semibold">Nadeenal  perera</h6>
              <p class="mb-0 text-muted"><i class="fas fa-phone me-1"></i> +94 70 456 7890</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<!-- Live Chart Modal -->
<div class="modal fade" id="liveChartModal" tabindex="-1" aria-labelledby="liveChartModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content" style="font-family: 'Poppins', sans-serif;">

      <!-- Modal Header -->
      <div class="modal-header bg-warning text-dark">
        <h5 class="modal-title" id="liveChartModalLabel"><i class="fas fa-chart-line"></i> Live Chart Feature</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body text-center">
        <div class="my-4">
          <i class="fas fa-chart-line fa-4x text-warning mb-3"></i>
          <h4 class="fw-bold">Live Chart Coming Soon!</h4>
          <p class="text-muted">This feature will allow you to visualize real-time data trends. Stay tuned for updates!</p>
        </div>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

<script>
    toastr.options = {
        "closeButton": true,
        "progressBar": true,
        "positionClass": "toast-bottom-right",
        "timeOut": "3000"
    };
   /*  function redirectToGoogle() {
        // Original URL
        const url = "https://www.posnation.com/support";
        
        // Encode URL to safely include special characters
        const encodedURL = encodeURI(url);

        // Redirect browser
        window.location.href = encodedURL;
    } */

    
</script>

</body>
</html>




