package com.PahanaOnlineBillingAuth.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.PahanaOnlineBilling.dao.ItemDAO;
import com.PahanaOnlineBilling.util.FlashMessage;
import PahanaOnlineBilling.modal.Item;

@WebServlet("/ItemServlet")
public class ItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        String itemIdStr = request.getParameter("itemId");
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String supplier = request.getParameter("supplier");

        double price = 0;
        int quantity = 0;
        int itemId = 0;

        try { price = Double.parseDouble(priceStr); } catch(Exception e){}
        try { quantity = Integer.parseInt(quantityStr); } catch(Exception e){}
        try { itemId = Integer.parseInt(itemIdStr); } catch(Exception e){}

        Item item = new Item();
        item.setItemId(itemId);
        item.setItemName(itemName);
        item.setCategory(category);
        item.setPrice(price);
        item.setQuantity(quantity);
        item.setSupplier(supplier);

        ItemDAO dao = new ItemDAO();

        if (action == null || action.equals("add")) {
            boolean inserted = dao.addItem(item);
            if (inserted) FlashMessage.setMessage(request,"success","Item added successfully!");
            else FlashMessage.setMessage(request,"danger","Failed to add item.");
            doGet(request,response);
            return;
        }

        if ("update".equals(action)) {
            boolean updated = dao.updateItem(item);
            if (updated) FlashMessage.setMessage(request,"success","Item updated successfully!");
            else FlashMessage.setMessage(request,"danger","Failed to update item.");
            doGet(request,response);
            return;
        }

        if ("delete".equals(action)) {
            boolean deleted = dao.deleteItem(itemId);
            if (deleted) FlashMessage.setMessage(request,"success","Item deleted successfully!");
            else FlashMessage.setMessage(request,"danger","Failed to delete item.");
            doGet(request,response);
            return;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ItemDAO dao = new ItemDAO();
        List<Item> list = dao.getAllItems();
        request.setAttribute("itemList", list);
        request.getRequestDispatcher("Views/Item.jsp").forward(request, response);
    }
}
