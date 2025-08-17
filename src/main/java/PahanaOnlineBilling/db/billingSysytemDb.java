package PahanaOnlineBilling.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class billingSysytemDb {
    // JDBC URL, username, password
    private static final String DB_URL = "jdbc:mysql://localhost:3306/PahnaEduDb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Method to get DB connection (new each time)
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        conn.setAutoCommit(true); // ensure auto commit
        return conn;
    }
}
