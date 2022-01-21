package Utility;

public class Cart {
    public int id;
    public String name;
    public int price;
    public int stock;

    public Cart(int productId, String productName, int price, int stock){
        this.id=productId;
        this.name=productName;
        this.price=price;
        this.stock=stock;
    }
}
