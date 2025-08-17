<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Pahana Edu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body {
      background: linear-gradient(135deg, #1E3A8A, #2563EB);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      font-family: 'Segoe UI', sans-serif;
    }
    .login-card {
      background: rgba(255, 255, 255, 0.15);
      backdrop-filter: blur(12px);
      border-radius: 15px;
      padding: 2rem;
      width: 100%;
      max-width: 400px;
      color: white;
      box-shadow: 0 4px 30px rgba(0,0,0,0.2);
      animation: fadeIn 0.6s ease-in-out;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .login-card h3 {
      font-weight: bold;
      margin-bottom: 1.5rem;
      text-align: center;
    }
    .form-control {
      background: rgba(255, 255, 255, 0.2);
      border: none;
      color: white;
      border-radius: 8px;
    }
    .form-control::placeholder {
      color: rgba(255, 255, 255, 0.7);
    }
    .btn-custom {
      background-color: #FACC15;
      color: #111827;
      font-weight: bold;
      border: none;
      border-radius: 8px;
    }
    .btn-custom:hover {
      background-color: #eab308;
      transform: scale(1.02);
    }
    .input-group-text {
      background: rgba(255, 255, 255, 0.2);
      border: none;
      color: white;
    }
    a {
      color: #FACC15;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="login-card">
    <h3><i class="fas fa-book-open"></i> Pahana Edu</h3>
   <form action="<%= request.getContextPath() %>/Loginservlet" method="post" class="animate-slide-up">
  <div class="mb-3">
    <label class="form-label">Username</label>
    <div class="input-group">
      <span class="input-group-text"><i class="fas fa-user"></i></span>
      <input type="text" class="form-control" name="username" placeholder="Enter username" required>
    </div>
  </div>
  <div class="mb-3">
    <label class="form-label">Password</label>
    <div class="input-group">
      <span class="input-group-text"><i class="fas fa-lock"></i></span>
      <input type="password" class="form-control" name="password" placeholder="Enter password" required>
    </div>
  </div>
  <button type="submit" class="btn btn-custom w-100">Login</button>

  <p class="text-center mt-2 text-danger">
    <% String error = request.getParameter("error"); 
       if(error != null) { out.print(error); } %>
  </p>

  <p class="text-center mt-3 mb-0" style="font-size: 0.9rem;">Forgot your password? <a href="#">Click here</a></p>
</form>

  </div>
</body>
</html>
