import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:xapptor_ui/models/lum/dispenser.dart';
import 'package:xapptor_ui/models/lum/product.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/lum/dispenser_details.dart';
import 'package:xapptor_ui/webview/webview.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({
    required this.vending_machine_id,
  });

  final String vending_machine_id;

  @override
  State<StatefulWidget> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<Product> products = [];
  List<Dispenser> dispensers = [];

  get_products() async {
    DocumentSnapshot vending_machine = await FirebaseFirestore.instance
        .collection("vending_machines")
        .doc(widget.vending_machine_id)
        .get();

    List vending_machine_dispensers = vending_machine["dispensers"];

    for (var dispenser in vending_machine_dispensers) {
      Dispenser current_dispenser =
          Dispenser.from_snapshot(dispenser as Map<String, dynamic>);

      DocumentSnapshot firestore_product = await FirebaseFirestore.instance
          .collection("products")
          .doc(current_dispenser.product_id)
          .get();

      products.add(
        Product.from_snapshot(
          firestore_product.id,
          firestore_product.data() as Map<String, dynamic>,
        ),
      );

      dispensers.add(current_dispenser);
    }

    for (var product in products) {
      print("products: " + product.url);
    }

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    get_products();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.length ~/ 2,
        itemBuilder: (context, i) {
          var first_index = i * 2;
          var second_index = first_index + 1;
          return Container(
            child: Column(
              children: [
                product_items_row(
                  first_index,
                  second_index,
                  context,
                  products,
                  dispensers[i],
                ),
                product_items_row(
                  first_index,
                  second_index,
                  context,
                  products,
                  dispensers[i],
                ),
                product_items_row(
                  first_index,
                  second_index,
                  context,
                  products,
                  dispensers[i],
                ),
                product_items_row(
                  first_index,
                  second_index,
                  context,
                  products,
                  dispensers[i],
                ),
                product_items_row(
                  first_index,
                  second_index,
                  context,
                  products,
                  dispensers[i],
                ),
              ],
            ),
          );

          // return product_items_row(
          //     first_index, second_index, context, products);
        },
      ),
    );
  }

  Widget product_items_row(
    int first_index,
    int second_index,
    BuildContext context,
    List<Product> products,
    Dispenser dispenser,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height / 5.8,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: product_item(
              products[first_index],
              context,
              dispensers[first_index],
              first_index.toString(),
            ),
          ),
          Expanded(
            flex: 1,
            child: product_item(
              products[second_index],
              context,
              dispensers[second_index],
              second_index.toString(),
            ),
          ),
        ],
      ),
    );
  }

  Widget product_item(
    Product product,
    BuildContext context,
    Dispenser dispenser,
    String dispenser_id,
  ) {
    double fractional_factor = 0.9;
    double index_tag_size = 30;
    return FractionallySizedBox(
      heightFactor: fractional_factor,
      widthFactor: fractional_factor,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
              ),
              elevation: MaterialStateProperty.all<double>(5),
            ),
            onPressed: () {
              print("dispenser_id: " + dispenser_id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DispenserDetails(
                    product: product,
                    dispenser: dispenser,
                    dispenser_id: dispenser_id,
                    allow_edit_enabled: false,
                  ),
                ),
              );
            },
            child: IgnorePointer(
              child: Webview(
                id: "20",
                src: product.url,
                function: () {},
              ),
            ),
          ),
          Container(
            height: index_tag_size,
            width: index_tag_size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color_lum_grey,
              borderRadius: BorderRadius.circular(
                1000,
              ),
            ),
            child: Text(
              dispenser_id,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
