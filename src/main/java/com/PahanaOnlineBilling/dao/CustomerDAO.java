package com.PahanaOnlineBilling.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import PahanaOnlineBilling.db.billingSysytemDb;
import PahanaOnlineBilling.modal.Customer;

public class CustomerDAO {

    // Add customer
    public boolean addCustomer(Customer customer) {
        boolean success = false;
        String sql = "INSERT INTO customers (account_no, full_name, address, phone) VALUES (?, ?, ?, ?)";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, customer.getAccountNo());
            ps.setString(2, customer.getFullName());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getPhone());

            int rows = ps.executeUpdate();
            success = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    // Get all customers
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerId(rs.getInt("id")); 
                c.setAccountNo(rs.getString("account_no"));
                c.setFullName(rs.getString("full_name"));
                c.setAddress(rs.getString("address"));
                c.setPhone(rs.getString("phone"));
                customers.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Update customer
    public boolean updateCustomer(Customer customer) {
        boolean success = false;
        String sql = "UPDATE customers SET full_name=?, address=?, phone=? WHERE account_no=?";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, customer.getFullName());
            ps.setString(2, customer.getAddress());
            ps.setString(3, customer.getPhone());
            ps.setString(4, customer.getAccountNo());

            int rows = ps.executeUpdate();
            success = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    // Delete customer
    public boolean deleteCustomer(String accountNo) {
        boolean success = false;
        String sql = "DELETE FROM customers WHERE account_no=?";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, accountNo);
            int rows = ps.executeUpdate();
            success = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    // ✅ Get customer by ID (for billing)
    public Customer getCustomerById(int customerId) {
        Customer customer = null;
        String sql = "SELECT * FROM customers WHERE id=?";

        try (Connection conn = billingSysytemDb.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    customer = new Customer();
                    customer.setCustomerId(rs.getInt("id"));
                    customer.setAccountNo(rs.getString("account_no"));
                    customer.setFullName(rs.getString("full_name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customer;
    }
}
