package com.PahanaOnlineBillingTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import com.PahanaOnlineBilling.dao.UserDAO;
import PahanaOnlineBilling.modal.User;
class JunitUserAuthTest {
	private UserDAO userDAO;

    @BeforeEach
    void setUp() {
        userDAO = new UserDAO();
    }

    @Test
    void testAuthenticateSuccess() {
       
        String testUsername = "dara";
        String testPassword = "123";

        User user = userDAO.authenticate(testUsername, testPassword);

        assertNotNull(user, "User should be authenticated successfully");
        assertEquals(testUsername, user.getUsername());
        assertEquals(testPassword, user.getPassword());
    }
    @Test
    void testAuthenticateFailure() {
        // Non-existing user
        String testUsername = "wronguser";
        String testPassword = "wrongpass";

        User user = userDAO.authenticate(testUsername, testPassword);

        // Assert authentication failed
        assertNull(user, "Authentication should fail for invalid credentials");
    }
	}


