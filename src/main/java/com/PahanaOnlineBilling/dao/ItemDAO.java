package com.PahanaOnlineBilling.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import PahanaOnlineBilling.db.billingSysytemDb;
import PahanaOnlineBilling.modal.Item;

public class ItemDAO {

    // Add new item
    public boolean addItem(Item item) {
        boolean success = false;
        String sql = "INSERT INTO items (item_name, category, price, quantity, supplier) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, item.getItemName());
            ps.setString(2, item.getCategory());
            ps.setDouble(3, item.getPrice());
            ps.setInt(4, item.getQuantity());
            ps.setString(5, item.getSupplier());

            int rows = ps.executeUpdate();
            success = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    // Get all items
    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items ORDER BY item_id";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getInt("item_id"));
                item.setItemName(rs.getString("item_name"));
                item.setCategory(rs.getString("category"));
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSupplier(rs.getString("supplier"));
                item.setCreatedAt(rs.getTimestamp("created_at"));
                items.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    // Search items
    public List<Item> searchItems(String keyword) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE item_name LIKE ? OR category LIKE ? OR supplier LIKE ? OR item_id LIKE ?";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String k = "%" + keyword + "%";
            ps.setString(1, k);
            ps.setString(2, k);
            ps.setString(3, k);
            ps.setString(4, k);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Item item = new Item();
                    item.setItemId(rs.getInt("item_id"));
                    item.setItemName(rs.getString("item_name"));
                    item.setCategory(rs.getString("category"));
                    item.setPrice(rs.getDouble("price"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setSupplier(rs.getString("supplier"));
                    item.setCreatedAt(rs.getTimestamp("created_at"));
                    items.add(item);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    // Update item
    public boolean updateItem(Item item) {
        boolean success = false;
        String sql = "UPDATE items SET item_name=?, category=?, price=?, quantity=?, supplier=? WHERE item_id=?";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, item.getItemName());
            ps.setString(2, item.getCategory());
            ps.setDouble(3, item.getPrice());
            ps.setInt(4, item.getQuantity());
            ps.setString(5, item.getSupplier());
            ps.setInt(6, item.getItemId());

            int rows = ps.executeUpdate();
            success = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    // Delete item
    public boolean deleteItem(int itemId) {
        boolean success = false;
        String sql = "DELETE FROM items WHERE item_id=?";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, itemId);
            int rows = ps.executeUpdate();
            success = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }
}
