package com.PahanaOnlineBillingTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import com.PahanaOnlineBilling.dao.CustomerDAO;
import PahanaOnlineBilling.modal.Customer;

class JunitCustomertest {
	private CustomerDAO customerDAO;
    @BeforeEach
    void setUp() {
        customerDAO = new CustomerDAO();
    }
    @Test
    void testDeleteCustomerSuccess() {
        // Step 1: Insert a customer first (so we have something to delete)
        Customer customer = new Customer();
        customer.setFullName("kasun");
        customer.setAddress("123 Test St");
        customer.setPhone("0123456789");

        boolean addResult = customerDAO.addCustomer(customer);
        assertTrue(addResult, "Customer should be added successfully before deletion");

        // Step 2: Delete the customer
        boolean deleteResult = customerDAO.deleteCustomer("ACC_TEST_DEL");

        // Step 3: Assert deletion was successful
        assertTrue(deleteResult, "Customer should be deleted successfully");
    }

    @Test
    void testAddCustomerSuccess() {
        // Create a customer object
        Customer customer = new Customer();
        customer.setAccountNo("ACC_TEST_001");
        customer.setFullName("kasun");
        customer.setAddress("123 Test St");
        customer.setPhone("0123456789");

      
        boolean result = customerDAO.addCustomer(customer);

     
        assertTrue(result, "Customer should be added successfully");

        customerDAO.deleteCustomer("ACC_TEST_001");
    }
}