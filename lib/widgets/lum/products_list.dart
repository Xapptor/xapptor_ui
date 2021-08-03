import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:xapptor_logic/firebase_tasks.dart';
import 'package:xapptor_ui/models/lum/dispenser.dart';
import 'package:xapptor_ui/models/lum/product.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/widgets/lum/dispenser_details.dart';
import 'package:xapptor_ui/webview/webview.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({
    required this.vending_machine_id,
    required this.allow_edit,
  });

  final String vending_machine_id;
  final bool allow_edit;

  @override
  State<StatefulWidget> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<Product> vending_machine_products = [];
  List<Product> products = [];
  List<Dispenser> dispensers = [];
  List<String> products_values = [];
  String products_value = "";

  get_products() async {
    DocumentSnapshot vending_machine = await FirebaseFirestore.instance
        .collection("vending_machines")
        .doc(widget.vending_machine_id)
        .get();

    List vending_machine_dispensers = vending_machine["dispensers"];

    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((snapshot_products) {
      for (var snapshot_product in snapshot_products.docs) {
        products.add(Product.from_snapshot(
          snapshot_product.id,
          snapshot_product.data() as Map<String, dynamic>,
        ));
      }
    });

    for (var dispenser in vending_machine_dispensers) {
      Dispenser current_dispenser =
          Dispenser.from_snapshot(dispenser as Map<String, dynamic>);

      Product current_product = products
          .firstWhere((product) => product.id == current_dispenser.product_id);

      vending_machine_products.add(current_product);

      dispensers.add(current_dispenser);
    }

    for (var product in products) {
      products_values.add(product.name);
      print("products: " + product.url);
    }
    products_value = products_values.first;
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
        itemCount: vending_machine_products.length,
        itemBuilder: (context, i) {
          return product_item(
            vending_machine_products[i],
            context,
            dispensers[i],
            i,
          );
        },
      ),
    );
  }

  Widget product_item(
    Product product,
    BuildContext context,
    Dispenser dispenser,
    int dispenser_id,
  ) {
    double fractional_factor = 0.9;
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: FractionallySizedBox(
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
                print("dispenser_id: " + (dispenser_id + 1).toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DispenserDetails(
                      product: product,
                      dispenser: dispenser,
                      dispenser_id: (dispenser_id + 1).toString(),
                      allow_edit: widget.allow_edit,
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
              padding: EdgeInsets.all(10),
              child: Text(
                (dispenser_id + 1).toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: color_lum_grey,
                ),
              ),
            ),
            !widget.allow_edit
                ? Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      alignment: Alignment.center,
                      icon: Icon(
                        Icons.edit,
                        color: color_lum_grey,
                      ),
                      onPressed: () {
                        show_product_picker_dialog(context, dispenser_id);
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  show_product_picker_dialog(BuildContext context, int index) async {
    double sized_box_height = 10;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (
              BuildContext context,
              StateSetter setState,
            ) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: sized_box_height),
                  Text(
                    "Selecciona el producto para este dispensador",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: sized_box_height),
                  DropdownButton<String>(
                    value: products_value,
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    underline: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    onChanged: (new_value) {
                      setState(() {
                        products_value = new_value!;
                      });
                    },
                    items: products_values
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: sized_box_height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () {
                          //Dispenser dispenser_updated = dispensers[index];
                          //dispenser_updated.product_id = products_value

                          update_item_in_array_field(
                            document_id: widget.vending_machine_id,
                            collection_id: "vending_machines",
                            field_key: "dispensers",
                            field_value: "",
                            index: index,
                          );
                          Navigator.pop(context);
                        },
                        child: Text("Aceptar"),
                      ),
                    ],
                  ),
                  SizedBox(height: sized_box_height),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
