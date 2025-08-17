package PahanaOnlineBilling.modal;

import java.sql.Timestamp;

public class Item {

    private int itemId;
    private String itemName;
    private String category;
    private double price;
    private int quantity;
    private String supplier;
    private Timestamp createdAt;

    // --- Constructors ---
    public Item() {}

    public Item(int itemId, String itemName, String category, double price, int quantity, String supplier, Timestamp createdAt) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.category = category;
        this.price = price;
        this.quantity = quantity;
        this.supplier = supplier;
        this.createdAt = createdAt;
    }

    // --- Getters & Setters ---
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getSupplier() { return supplier; }
    public void setSupplier(String supplier) { this.supplier = supplier; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
