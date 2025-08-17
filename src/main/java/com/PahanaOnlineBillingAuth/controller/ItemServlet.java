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
        ItemDAO dao = new ItemDAO();

        // Common inputs
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        double price = 0;
        int quantity = 0;
        try { price = Double.parseDouble(request.getParameter("price")); } catch(Exception e){}
        try { quantity = Integer.parseInt(request.getParameter("quantity")); } catch(Exception e){}
        String supplier = request.getParameter("supplier");

        if(action == null || action.equals("add")) {
            // Add action: itemId not set, DB handles it
            Item item = new Item(itemName, category, price, quantity, supplier);
            boolean inserted = dao.addItem(item);
            FlashMessage.setMessage(request, inserted ? "success" : "danger", 
                inserted ? "Item added successfully!" : "Failed to add item.");
        }
        else if("update".equals(action)) {
            // Update action requires itemId
            int itemId = 0;
            try { itemId = Integer.parseInt(request.getParameter("itemId")); } catch(Exception e){}
            Item item = new Item();
            item.setItemId(itemId);
            item.setItemName(itemName);
            item.setCategory(category);
            item.setPrice(price);
            item.setQuantity(quantity);
            item.setSupplier(supplier);

            boolean updated = dao.updateItem(item);
            FlashMessage.setMessage(request, updated ? "success" : "danger", 
                updated ? "Item updated successfully!" : "Failed to update item.");
        }
        else if("delete".equals(action)) {
            int itemId = 0;
            try { itemId = Integer.parseInt(request.getParameter("itemId")); } catch(Exception e){}
            boolean deleted = dao.deleteItem(itemId);
            FlashMessage.setMessage(request, deleted ? "success" : "danger", 
                deleted ? "Item deleted successfully!" : "Failed to delete item.");
        }

        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ItemDAO dao = new ItemDAO();
        String search = request.getParameter("search");
        List<Item> list;

        if(search != null && !search.trim().isEmpty()) {
            list = dao.searchItems(search.trim());
        } else {
            list = dao.getAllItems();
        }

        request.setAttribute("itemList", list);
        request.getRequestDispatcher("Views/Item.jsp").forward(request, response);
    }
}

