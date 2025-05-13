void main(){
  print("Product Management");
  Product product1 = Product(1, "Laptop", "HP",850000);
  Product product2 = Product(2, "Smart Phone", "Samsung", 60000);
  Product product3 = Product(3, "Tablet", "Apple", 50000);
  Product product4 = Product(4, "Smart Watch", "Fossil", 20000);
  Product product5 = Product(5, "Headphones", "Sony", 5000);
  Product product6 = Product(6, "Smart TV", "LG", 80000);
  Product product7 = Product(7, "Camera", "Canon", 70000);
  Product product8 = Product(8, "Printer", "HP", 15000);
  Product product9 = Product(9, "Monitor", "Dell", 20000);
  Product product10 = Product(10, "Keyboard", "Logitech", 2000);
  ProductManagement productManagement = ProductManagement();
  productManagement.addProduct(product1);
  productManagement.addProduct(product2);
  productManagement.addProduct(product3);
  productManagement.addProduct(product4);
  productManagement.addProduct(product5);
  productManagement.addProduct(product6);
  productManagement.addProduct(product7);
  productManagement.addProduct(product8);
  productManagement.addProduct(product9);
  productManagement.addProduct(product10);
  productManagement.displayProducts();
  print("Search by supplier:");
  productManagement.searchSupplier("HP");
  print("Search by product name:");
  productManagement.searchProduct("Smart Phone");
  print("Search by price:");
  productManagement.searchPrice(10000, 60000);


}

class Product{
  int? id;
  String? name;  
  String? supplier;
  int? price;  

  Product(this.id, this.name, this.supplier, this.price);
  
  @override
  String toString() {
    return 'Product(id: $id, name: $name, supplier: $supplier, price: $price)';
  } 
}

class ProductManagement{
  List<Product> products = [];
  
  void addProduct(Product product){
    products.add(product);
  }
  
   
  void displayProducts(){
    for (var product in products) {
      print(product);
    }
  } 

  void searchSupplier(String supplier){
    for (var product in products) {
      if (product.supplier == supplier) {
        print(product);
      }
    }
  }

  void searchProduct(String name){
    for (var product in products) {
      if (product.name == name) {
        print(product);
      }
    }
  }

  void searchPrice(int minprice,int maxprice){
    for (var product in products) {
      if (product.price! >= minprice && product.price! <= maxprice) {
        print(product);
      }
    }
    
  }
}