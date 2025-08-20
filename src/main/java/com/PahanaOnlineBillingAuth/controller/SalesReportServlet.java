package com.PahanaOnlineBillingAuth.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.PahanaOnlineBilling.dao.BillDAO;
import com.PahanaOnlineBilling.dao.BillItemDAO;

import PahanaOnlineBilling.modal.Bill;
import PahanaOnlineBilling.modal.BillItem;

/**
 * Servlet implementation class SalesReportServlet
 */
@WebServlet("/SalesReportServlet")
public class SalesReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private BillDAO billDAO;
    private BillItemDAO billItemDAO;

    @Override
    public void init() throws ServletException {
        billDAO = new BillDAO();
        billItemDAO = new BillItemDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1) Fetch all bills
        List<Bill> bills = billDAO.getAllBills(); // implement this method in BillDAO

        // 2) For each bill, fetch its items
        for (Bill bill : bills) {
            List<BillItem> items = billItemDAO.getItemsByBillId(bill.getBillId());
            bill.setItems(items); // Assuming Bill modal has setItems(List<BillItem>)
        }

        // 3) Set attributes and forward to JSP
        request.setAttribute("bills", bills);
        RequestDispatcher rd = request.getRequestDispatcher("Views/SalesReport.jsp");
        rd.forward(request, response);
    }
}