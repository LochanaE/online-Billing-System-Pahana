package com.PahanaOnlineBilling.dao;

import java.sql.*;
import java.util.*;
import PahanaOnlineBilling.modal.BillItem;
import PahanaOnlineBilling.modal.Item;
import PahanaOnlineBilling.db.billingSysytemDb; // DB connection class

public class BillItemDAO {

    public BillItemDAO() {
        // Empty constructor
    }

    // Get list of BillItems by billId
    public List<BillItem> getItemsByBillId(int billId) {
        List<BillItem> items = new ArrayList<>();
        String sql = "SELECT bi.id, bi.item_id, bi.quantity, bi.price, i.item_name " +
                     "FROM bill_items bi JOIN item i ON bi.item_id = i.item_id " +
                     "WHERE bi.bill_id = ?";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BillItem bi = new BillItem();
                    bi.setId(rs.getInt("id"));

                    Item it = new Item();
                    it.setItemId(rs.getInt("item_id"));
                    it.setItemName(rs.getString("item_name"));
                    it.setPrice(rs.getDouble("price"));

                    bi.setItem(it);
                    bi.setQuantity(rs.getInt("quantity"));
                    bi.setPrice(rs.getDouble("price")); // price per unit
                    items.add(bi);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }
}
