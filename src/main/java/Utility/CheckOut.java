package Utility;

public class CheckOut {
    public int productId,quantity;
    public String productName;
    public double price;
    public static double grandTotal;
    public CheckOut(int productId,String productName,int quantity,double price){
        this.productId=productId;
        this.productName=productName;
        this.quantity=quantity;
        this.price=price;
    }
}
