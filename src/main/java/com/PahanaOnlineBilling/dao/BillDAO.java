package com.PahanaOnlineBilling.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

import PahanaOnlineBilling.db.billingSysytemDb;

public class BillDAO {

    // Insert bill and return generated bill_id
    public int insertBill(int customerId, double total) {
        int generatedId = -1;
        String sql = "INSERT INTO bill (customer_id, bill_date, total_amount) VALUES (?, NOW(), ?)";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, customerId);
            ps.setDouble(2, total);

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    // Insert individual bill items
    public void insertBillItem(int billId, int itemId, int qty, double price) {
        String sql = "INSERT INTO bill_items (bill_id, item_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billId);
            ps.setInt(2, itemId);
            ps.setInt(3, qty);
            ps.setDouble(4, price);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Optional: Insert bill + items in one transaction
    public int insertBillWithItems(int customerId, java.util.List<PahanaOnlineBilling.modal.Item> items) {
        int billId = -1;
        String sqlBill = "INSERT INTO bill (customer_id, bill_date, total_amount) VALUES (?, NOW(), ?)";
        String sqlItem = "INSERT INTO bill_items (bill_id, item_id, quantity, price) VALUES (?, ?, ?, ?)";

        double totalAmount = 0;
        for (PahanaOnlineBilling.modal.Item it : items) {
            totalAmount += it.getPrice() * it.getQuantity();
        }

        try (Connection conn = billingSysytemDb.getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            // Insert bill
            try (PreparedStatement psBill = conn.prepareStatement(sqlBill, Statement.RETURN_GENERATED_KEYS)) {
                psBill.setInt(1, customerId);
                psBill.setDouble(2, totalAmount);
                psBill.executeUpdate();
                try (ResultSet rs = psBill.getGeneratedKeys()) {
                    if (rs.next()) {
                        billId = rs.getInt(1);
                    } else {
                        throw new SQLException("Failed to retrieve generated bill ID");
                    }
                }
            }

            // Insert bill items
            try (PreparedStatement psItem = conn.prepareStatement(sqlItem)) {
                for (PahanaOnlineBilling.modal.Item it : items) {
                    psItem.setInt(1, billId);
                    psItem.setInt(2, it.getItemId());
                    psItem.setInt(3, it.getQuantity());
                    psItem.setDouble(4, it.getPrice());
                    psItem.addBatch();
                }
                psItem.executeBatch();
            }

            conn.commit(); // Commit transaction
        } catch (SQLException e) {
            e.printStackTrace();
            billId = -1;
        }

        return billId;
    }
}
