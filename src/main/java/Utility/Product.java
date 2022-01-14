package Utility;

public class Product {
    public int id;
    public int price;
    public int per;
    public String unit;
    public String name;
    public int stock;

    public Product(int id, int price, int per, String unit, String name, int stock) {
        this.id = id;
        this.price = price;
        this.per = per;
        this.unit = unit;
        this.name = name;
        this.stock = stock;
    }
}
