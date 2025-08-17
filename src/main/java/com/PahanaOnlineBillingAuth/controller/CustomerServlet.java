package com.PahanaOnlineBillingAuth.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.PahanaOnlineBilling.dao.CustomerDAO;
import com.PahanaOnlineBilling.util.FlashMessage;

import PahanaOnlineBilling.modal.Customer;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // POST method => both add and update handle करද්දි
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * JSP එකෙන් hidden input එකක් "action" කියලා එවමු:
         * action="add" => insert logic use වෙනවා
         * action="update" => update logic trigger වෙනවා
         */
        
        String action = request.getParameter("action");

        // common inputs
        String accountNo = request.getParameter("accountNo");
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // DAO object
        CustomerDAO dao = new CustomerDAO();

        // Insert / update object
        Customer customer = new Customer();
        customer.setAccountNo(accountNo);
        customer.setFullName(fullName);
        customer.setAddress(address);
        customer.setPhone(phone);

        // If no action param => treat as add
        if (action == null || action.equals("add")) {

            boolean inserted = dao.addCustomer(customer);
            if (inserted) {
                FlashMessage.setMessage(request, "success", "Customer added successfully!");
            } else {
                FlashMessage.setMessage(request, "danger", "Failed to add customer.");
            }
            /*
             * redirect to doGet => page refresh with list
             * doGet() method fetches data again
             */
            doGet(request, response);
            return;
        }

        // If action=update => update logic run
        if (action.equals("update")) {

            boolean updated = dao.updateCustomer(customer);
            if (updated) {
                FlashMessage.setMessage(request, "success", "Customer updated successfully!");
            } else {
                FlashMessage.setMessage(request, "danger", "Failed to update customer.");
            }
            doGet(request, response);
            return;
        }
        else if("delete".equals(action)) {
            String ac = request.getParameter("accountNo");
            boolean deleted = dao.deleteCustomer(ac);
            if(deleted) {
                FlashMessage.setMessage(request, "success", "Customer deleted successfully!");
            } else {
                FlashMessage.setMessage(request, "danger", "Failed to delete customer.");
            }
            doGet(request, response);
            return;
        }
    }

    /**
     * This method loads customer list and forward to JSP
     * Used for first page load and after insert/update both
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CustomerDAO dao = new CustomerDAO();
        List<Customer> list = dao.getAllCustomers();

        // set attribute to be used in JSP table
        request.setAttribute("customerList", list);

        // forward to AddCustomer.jsp
        request.getRequestDispatcher("Views/AddCustomer.jsp").forward(request, response);
    }
}



  
