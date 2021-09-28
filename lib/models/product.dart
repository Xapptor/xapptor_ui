class Product {
  const Product({
    required this.id,
    this.stripe_id = "",
    required this.name,
    required this.image_src,
    required this.price,
    required this.description,
    this.enabled = true,
  });

  final String id;
  final String stripe_id;
  final String name;
  final String image_src;
  final int price;
  final String description;
  final bool enabled;

  Product.from_snapshot(
    String id,
    Map<String, dynamic> snapshot,
  )   : id = id,
        stripe_id = snapshot['stripe_id'] ?? "",
        //stripe_id = snapshot['stripe_id_test'] ?? "",
        name = snapshot['name'],
        image_src = snapshot['image_src'],
        price = snapshot['price'],
        enabled = snapshot['enabled'] ?? true,
        description = snapshot['description'] ?? "";

  Map<String, dynamic> to_json() {
    return {
      'name': name,
      'image': image_src,
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
