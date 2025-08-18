<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" x-data="{ openFaq: null }" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>Help & Support - POS System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        <button onclick="toastr.success('Support request sent via Email!')"
                class="w-full bg-blue-600 text-white py-3 rounded-lg shadow hover:bg-blue-700">
            <i class="fas fa-envelope"></i> Contact via Email
        </button>

        <button onclick="toastr.info('Calling support hotline...')"
                class="w-full bg-green-600 text-white py-3 rounded-lg shadow hover:bg-green-700">
            <i class="fas fa-phone"></i> Call Support
        </button>

        <button onclick="toastr.warning('Live chat feature coming soon!')"
                class="w-full bg-yellow-500 text-white py-3 rounded-lg shadow hover:bg-yellow-600">
            <i class="fas fa-comments"></i> Live Chat
        </button>
    </div>

</div>

<!-- Toastr Config -->
<script>
    toastr.options = {
        "closeButton": true,
        "progressBar": true,
        "positionClass": "toast-bottom-right",
        "timeOut": "3000"
    };
</script>

</body>
</html>




<!-- <!DOCTYPE html>
<html lang="en" x-data="{ sidebarOpen: false, modalOpen: false }" class="h-full bg-gray-100">
<head>
<meta charset="UTF-8">
<title>Modern POS Dashboard</title>
Tailwind CSS
<script src="https://cdn.tailwindcss.com"></script>
Alpine.js
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
FontAwesome
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
Toastr
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body class="h-full font-sans text-gray-900">

Sidebar
<div class="flex h-screen overflow-hidden">
  <aside :class="sidebarOpen ? 'translate-x-0' : '-translate-x-full'" class="fixed z-30 inset-y-0 left-0 w-64 transition transform bg-gradient-to-b from-blue-700 to-blue-900 text-white shadow-xl md:relative md:translate-x-0">
    <div class="flex items-center justify-center h-16 border-b border-blue-600">
      <a href="#" class="text-white font-bold text-xl flex items-center"><i class="fas fa-cash-register mr-2"></i> POS System</a>
    </div>
    <nav class="mt-5 px-4 space-y-2">
      <a href="#" class="flex items-center py-2 px-3 rounded-lg hover:bg-blue-600 transition"><i class="fas fa-home mr-3"></i> Dashboard</a>
      <a href="#" class="flex items-center py-2 px-3 rounded-lg hover:bg-blue-600 transition"><i class="fas fa-box mr-3"></i> Items</a>
      <a href="#" class="flex items-center py-2 px-3 rounded-lg hover:bg-blue-600 transition"><i class="fas fa-users mr-3"></i> Customers</a>
      <a href="#" class="flex items-center py-2 px-3 rounded-lg hover:bg-blue-600 transition"><i class="fas fa-receipt mr-3"></i> Bills</a>
      <button @click="modalOpen = true" class="w-full flex items-center justify-center py-2 mt-4 rounded-lg bg-yellow-400 text-black hover:bg-yellow-500 transition"><i class="fas fa-plus mr-2"></i> Add Item</button>
    </nav>
  </aside>

  Main content
  <div class="flex-1 flex flex-col overflow-auto">
    Navbar
    <header class="flex items-center justify-between bg-white shadow-md h-16 px-6">
      <button @click="sidebarOpen = !sidebarOpen" class="md:hidden text-gray-700 focus:outline-none">
        <i class="fas fa-bars"></i>
      </button>
      <div class="flex items-center space-x-4">
        <input type="text" placeholder="Search..." class="border rounded-lg px-3 py-1 focus:outline-none focus:ring-2 focus:ring-blue-500">
        <i class="fas fa-bell text-gray-500 cursor-pointer hover:text-gray-700"></i>
        <img src="https://i.pravatar.cc/40" class="rounded-full w-10 h-10 border">
      </div>
    </header>

    Content
    <main class="flex-1 p-6 bg-gray-100">
      <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">

        Card 1
        <div class="bg-white p-6 rounded-2xl shadow hover:shadow-xl transition">
          <h3 class="text-lg font-semibold mb-2 text-blue-600 flex items-center"><i class="fas fa-chart-line mr-2"></i> Sales</h3>
          <p class="text-3xl font-bold">$12,450</p>
          <p class="text-sm text-gray-500 mt-1">This month</p>
        </div>

        Card 2
        <div class="bg-white p-6 rounded-2xl shadow hover:shadow-xl transition">
          <h3 class="text-lg font-semibold mb-2 text-green-600 flex items-center"><i class="fas fa-users mr-2"></i> Customers</h3>
          <p class="text-3xl font-bold">324</p>
          <p class="text-sm text-gray-500 mt-1">Active customers</p>
        </div>

        Card 3
        <div class="bg-white p-6 rounded-2xl shadow hover:shadow-xl transition">
          <h3 class="text-lg font-semibold mb-2 text-yellow-600 flex items-center"><i class="fas fa-box mr-2"></i> Items</h3>
          <p class="text-3xl font-bold">58</p>
          <p class="text-sm text-gray-500 mt-1">In inventory</p>
        </div>
      </div>

      Table
      <div class="mt-8 bg-white p-6 rounded-2xl shadow overflow-x-auto">
        <h3 class="text-lg font-semibold mb-3 text-purple-600 flex items-center"><i class="fas fa-table mr-2"></i> Recent Bills</h3>
        <table class="w-full text-left border border-gray-200 rounded-lg overflow-hidden">
          <thead class="bg-purple-600 text-white">
            <tr>
              <th class="px-3 py-2">#</th>
              <th class="px-3 py-2">Customer</th>
              <th class="px-3 py-2">Items</th>
              <th class="px-3 py-2">Total</th>
              <th class="px-3 py-2">Date</th>
            </tr>
          </thead>
          <tbody>
            <tr class="hover:bg-gray-100">
              <td class="px-3 py-2">1</td>
              <td class="px-3 py-2">John Doe</td>
              <td class="px-3 py-2">3</td>
              <td class="px-3 py-2">$120</td>
              <td class="px-3 py-2">2025-08-18</td>
            </tr>
            <tr class="hover:bg-gray-100">
              <td class="px-3 py-2">2</td>
              <td class="px-3 py-2">Jane Smith</td>
              <td class="px-3 py-2">2</td>
              <td class="px-3 py-2">$75</td>
              <td class="px-3 py-2">2025-08-17</td>
            </tr>
          </tbody>
        </table>
      </div>

    </main>
  </div>
</div>

Add Item Modal
<div x-show="modalOpen" class="fixed inset-0 flex items-center justify-center z-50 bg-black bg-opacity-50">
  <div @click.away="modalOpen=false" class="bg-white rounded-2xl shadow-lg w-11/12 md:w-1/2 p-6 animate-fadeIn">
    <div class="flex justify-between items-center mb-4">
      <h3 class="text-lg font-semibold text-blue-600"><i class="fas fa-plus mr-2"></i> Add New Item</h3>
      <button @click="modalOpen=false" class="text-gray-600 hover:text-gray-800"><i class="fas fa-times"></i></button>
    </div>
    <form>
      <div class="mb-4">
        <label class="block font-medium mb-1">Item Name</label>
        <input type="text" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
      </div>
      <div class="mb-4">
        <label class="block font-medium mb-1">Quantity</label>
        <input type="number" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
      </div>
      <div class="flex justify-end">
        <button type="button" @click="modalOpen=false; toastr.success('Item added successfully');" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition"><i class="fas fa-check mr-2"></i> Save</button>
      </div>
    </form>
  </div>
</div>

<script>
toastr.options = {
  closeButton: false,
  progressBar: true,
  positionClass: "toast-top-right",
  timeOut: "3000"
};
</script>

</body>
</html>
 -->