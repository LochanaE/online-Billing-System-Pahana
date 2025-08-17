<%@ page import="java.util.List" %>
<%@ page import="PahanaOnlineBilling.modal.Item" %>
<%@ page import="PahanaOnlineBilling.modal.Customer" %>
<%
    Customer customer = (Customer) request.getAttribute("customer");
    List<Item> billItems = (List<Item>) request.getAttribute("billItems");
    double totalAmount = (double) request.getAttribute("totalAmount");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Invoice Preview</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.invoice-box {
    max-width: 800px;
    margin: auto;
    padding: 30px;
    border: 1px solid #eee;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,.15);
    font-size: 16px;
    line-height: 24px;
    color: #555;
}
.table thead { background: #2563EB; color: #fff; }
</style>
</head>
<body>

<div class="invoice-box mt-4">
    <h2 class="text-center mb-4">Invoice Preview</h2>
    <div class="row mb-3">
        <div class="col-6">
            <strong>FROM:</strong><br>
            Pahana Edu<br>
            Your Address<br>
            Phone / Email
        </div>
        <div class="col-6">
            <strong>BILLED TO:</strong><br>
            <%= customer.getFullName() %><br>
            <%= customer.getAddress() %><br>
            <%= customer.getPhone() %><br>
          
        </div>
    </div>

    <div class="table-responsive mb-3">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Item</th>
                    <th>Qty</th>
                    <th>Price</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 1;
                    double subtotal = 0;
                    for(Item it : billItems) {
                        double amount = it.getPrice() * it.getQuantity();
                        subtotal += amount;
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= it.getItemName() %></td>
                    <td><%= it.getQuantity() %></td>
                    <td>$<%= it.getPrice() %></td>
                    <td>$<%= amount %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <div class="text-end mb-4">
        <p>Sub Total: $<%= subtotal %></p>
        <%
            double tax = subtotal * 0.05; // 5% tax
            double grandTotal = subtotal + tax;
        %>
        <p>Tax (5%): $<%= tax %></p>
        <h4>Total: $<%= grandTotal %></h4>
    </div>

    <div class="text-center">
        <button class="btn btn-success" onclick="window.print();">
            <i class="fas fa-print"></i> Print Bill
        </button>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
