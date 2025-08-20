package com.PahanaOnlineBilling.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import PahanaOnlineBilling.db.billingSysytemDb;
import PahanaOnlineBilling.modal.User;

public class UserDAO {
	 public User authenticate(String username, String password) {
	        User user = null;
	        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

	        try {
	            Connection conn = billingSysytemDb.getConnection();
	            PreparedStatement stmt = conn.prepareStatement(sql);
	            stmt.setString(1, username);
	            stmt.setString(2, password);
	            ResultSet rs = stmt.executeQuery();

	            if(rs.next()) {
	                user = new User();
	                user.setId(rs.getInt("id"));
	                user.setUsername(rs.getString("username"));
	                user.setPassword(rs.getString("password"));
	                user.setRole(rs.getString("role"));
	            }

	            rs.close();
	            stmt.close();
	        } catch(SQLException e) {
	            e.printStackTrace();
	        }

	        return user;
	    }
	 
	 //add user
	
	    public boolean addUser(User user) {
	        boolean success = false;
	        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";

	        try (Connection conn = billingSysytemDb.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {

	            ps.setString(1, user.getUsername());
	            ps.setString(2, user.getPassword());
	            ps.setString(3, user.getRole());

	           

	            int rows = ps.executeUpdate();
	            success = rows > 0;

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return success;
	    }
	    
	 // Get all users
	    public List<User> getAllUsers() {
	        List<User> users = new ArrayList<>();
	        String sql = "SELECT * FROM users ORDER BY id DESC";

	        try (Connection conn = billingSysytemDb.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql);
	             ResultSet rs = ps.executeQuery()) {

	            while (rs.next()) {
	                User u = new User();
	                u.setId(rs.getInt("id"));
	                u.setUsername(rs.getString("username"));
	                u.setPassword(rs.getString("password"));
	                u.setRole(rs.getString("role"));
	                users.add(u);
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return users;
	    }

	    // Search user by username
	    public User getUserByUsername(String username) {
	        User user = null;
	        String sql = "SELECT * FROM users WHERE username = ?";

	        try (Connection conn = billingSysytemDb.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {

	            ps.setString(1, username);
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    user = new User();
	                    user.setId(rs.getInt("id"));
	                    user.setUsername(rs.getString("username"));
	                    user.setPassword(rs.getString("password"));
	                    user.setRole(rs.getString("role"));
	                }
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return user;
	    }

	    // Update user
	    public boolean updateUser(User user) {
	        StringBuilder sql = new StringBuilder("UPDATE users SET role=? ");
	        // password is optional – only update if not empty
	        if (user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
	            sql.append(", password=? ");
	        }
	        sql.append("WHERE username=?");

	        try (Connection conn = billingSysytemDb.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

	            ps.setString(1, user.getRole());

	            if (user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
	                ps.setString(2, user.getPassword());
	                ps.setString(3, user.getUsername());
	            } else {
	                ps.setString(2, user.getUsername());
	            }

	            return ps.executeUpdate() > 0;

	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }

	    // Delete user
	    public boolean deleteUser(String username) {
	        String sql = "DELETE FROM users WHERE username = ?";
	        try (Connection conn = billingSysytemDb.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {

	            ps.setString(1, username);
	            return ps.executeUpdate() > 0;

	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	
}
