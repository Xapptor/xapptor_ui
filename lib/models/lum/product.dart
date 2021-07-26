class Product {
  final String id;
  final String name;
  final String url;
  final int price;

  const Product({
    required this.id,
    required this.name,
    required this.url,
    required this.price,
  });

  Product.from_snapshot(String id, Map<String, dynamic> snapshot)
      : id = id,
        name = snapshot['name'],
        url = snapshot['url'],
        price = snapshot['price'];

  Map<String, dynamic> to_json() {
    return {
      'name': name,
      'image': url,
      'price': price,
    };
  }
}
