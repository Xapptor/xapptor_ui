class Product {
  final String id;
  final String name;
  final String url;
  final int price;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.url,
    required this.price,
    required this.description,
  });

  Product.from_snapshot(String id, Map<String, dynamic> snapshot)
      : id = id,
        name = snapshot['name'],
        url = snapshot['url'],
        price = snapshot['price'],
        description = snapshot['description'];

  Map<String, dynamic> to_json() {
    return {
      'name': name,
      'image': url,
      'price': price,
      'description': description,
    };
  }
}

List<Map<String, dynamic>> product_list_to_json_list(List<Product> products) {
  List<Map<String, dynamic>> json_list = [];

  products.forEach((product) {
    json_list.add(product.to_json());
  });

  return json_list;
}
