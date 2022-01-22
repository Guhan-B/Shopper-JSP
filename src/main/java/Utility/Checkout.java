package Utility;

public class Checkout {
    public int productId,quantity;
    public String productName;
    public double price;

    public Checkout(int productId, String productName, int quantity, double price){
        this.productId=productId;
        this.productName=productName;
        this.quantity=quantity;
        this.price=price;
    }
}
