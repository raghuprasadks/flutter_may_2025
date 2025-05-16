import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    home: ProductCRUD(),
    debugShowCheckedModeBanner: false,
  ));
}

class Product {
  final int id;
  final String name;
  final String supplier;
  final double price;

  Product({required this.id, required this.name, required this.supplier, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      supplier: json['supplier'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'supplier': supplier,
    'price': price,
  };
}

class ProductCRUD extends StatefulWidget {
  const ProductCRUD({Key? key}) : super(key: key);

  @override
  State<ProductCRUD> createState() => _ProductCRUDState();
}

class _ProductCRUDState extends State<ProductCRUD> {
  final String apiUrl = 'http://localhost:5000/api/products'; // Replace with your API URL
  List<Product> products = [];
  final nameController = TextEditingController();
  final supplierController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        products = data.map((json) => Product.fromJson(json)).toList();
      });
    }
  }

  Future<void> addProduct() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': nameController.text,
        'supplier': supplierController.text,
        'price': double.tryParse(priceController.text) ?? 0.0,
      }),
    );
    if (response.statusCode == 201) {
      fetchProducts();
      nameController.clear();
      supplierController.clear();
      priceController.clear();
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product CRUD')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: supplierController,
              decoration: const InputDecoration(labelText: 'Supplier'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: addProduct,
              child: const Text('Add Product'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('Supplier: ${product.supplier} | Price: ₹${product.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteProduct(product.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}