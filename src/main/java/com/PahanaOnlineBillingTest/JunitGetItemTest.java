package com.PahanaOnlineBillingTest;
import static org.junit.jupiter.api.Assertions.*;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import com.PahanaOnlineBilling.dao.ItemDAO;
import PahanaOnlineBilling.modal.Item;

class JunitGetItemTest {
	private ItemDAO itemDAO;
    @BeforeEach
    void setUp() {
        itemDAO = new ItemDAO();
    }
    @Test
    void testGetAllItemsNotEmpty() {
        // Call method
        List<Item> items = itemDAO.getAllItems();

        assertNotNull(items, "Item list should not be null");
        assertTrue(items.size() > 0, "Item list should not be empty");
    }
    @Test
    void testGetAllItemsFields() {
        List<Item> items = itemDAO.getAllItems();

        if (!items.isEmpty()) {
            Item firstItem = items.get(0);

           
            assertNotNull(firstItem.getItemId(), "Item ID should not be null");
            assertNotNull(firstItem.getItemName(), "Item name should not be null");
            assertNotNull(firstItem.getCategory(), "Category should not be null");
            assertNotNull(firstItem.getSupplier(), "Supplier should not be null");
        }
    }
	}

