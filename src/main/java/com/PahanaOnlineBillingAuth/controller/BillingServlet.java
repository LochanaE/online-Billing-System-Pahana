package com.PahanaOnlineBillingAuth.controller;

import java.io.IOException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.PahanaOnlineBilling.dao.CustomerDAO;
import com.PahanaOnlineBilling.dao.ItemDAO;
import com.PahanaOnlineBilling.dao.BillDAO;

import PahanaOnlineBilling.modal.Customer;
import PahanaOnlineBilling.modal.Item;

@WebServlet("/BillingServlet")
public class BillingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CustomerDAO customerDAO;
    private ItemDAO itemDAO;
    private BillDAO billDAO;

    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        itemDAO     = new ItemDAO();
        billDAO     = new BillDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Customer> customers = customerDAO.getAllCustomers();
        List<Item> items = itemDAO.getAllItems();

        request.setAttribute("customerList", customers);
        request.setAttribute("itemList", items);

        RequestDispatcher rd = request.getRequestDispatcher("Views/Billing.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1) Get form params
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        
        // get list of items selected
        String[] itemIds = request.getParameterValues("itemIds");
        if(itemIds == null || itemIds.length == 0) {
            // No items selected, redirect
            response.sendRedirect("BillingServlet");
            return;
        }

        // 2) Loop each item and store qty + price
        List<Item> selectedItems = new ArrayList<>();
        double totalAmount = 0.0;

        for(String idStr : itemIds) {
            int itemId = Integer.parseInt(idStr);
            Item it = itemDAO.getItemById(itemId); // implement getItemById()
            
            // qty field name = "qty_" + itemId
            int qty = Integer.parseInt(request.getParameter("qty_" + itemId));
            
            // compute subtotal
            double sub = it.getPrice() * qty;
            totalAmount += sub;
            
            // temporarily store qty inside item object
            it.setQuantity(qty);
            selectedItems.add(it);
        }

        // 3) Insert into bill table => returns new bill_id
        int billId = billDAO.insertBill(customerId, totalAmount);

        // 4) Insert into bill_items table & reduce stock
        for(Item it : selectedItems) {
            billDAO.insertBillItem(billId, it.getItemId(), it.getQuantity(), it.getPrice());
            itemDAO.reduceStock(it.getItemId(), it.getQuantity()); // update stock
        }

        // 5) Forward to InvoiceView.jsp for preview & print
        Customer customer = customerDAO.getCustomerById(customerId); // implement this method
        request.setAttribute("billId", billId);
        request.setAttribute("customer", customer);
        request.setAttribute("billItems", selectedItems);
        request.setAttribute("totalAmount", totalAmount);

        RequestDispatcher rd = request.getRequestDispatcher("Views/Billing.jsp");
        rd.forward(request, response);
    }
}
