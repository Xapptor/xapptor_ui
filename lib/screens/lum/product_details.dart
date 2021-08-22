import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/models/lum/product.dart';
import 'package:xapptor_ui/values/custom_colors.dart';
import 'package:xapptor_ui/values/ui.dart';
import 'package:xapptor_ui/widgets/custom_card.dart';
import 'package:xapptor_ui/widgets/topbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    required this.product,
  });

  final Product? product;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  TextEditingController _controller_name = TextEditingController();
  TextEditingController _controller_description = TextEditingController();
  TextEditingController _controller_price = TextEditingController();
  bool is_editing = false;
  String url = "";
  String current_image_file_base64 = "";
  String current_image_file_name = "";
  String upload_image_button_label = "Subir imágen SVG";

  @override
  void dispose() {
    _controller_name.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    set_values();
  }

  set_values() {
    _controller_name.text = widget.product?.name ?? "";
    _controller_price.text = widget.product?.price.toString() ?? "";
    _controller_description.text = widget.product?.description ?? "";
    url = widget.product?.url ?? "";
  }

  show_save_data_alert_dialog({
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¿Deseas guardar los cambios?"),
          actions: <Widget>[
            TextButton(
              child: Text("Descartar cambios"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Aceptar"),
              onPressed: () async {
                if (widget.product == null) {
                  if (current_image_file_base64 == "") {
                    SnackBar snackBar = SnackBar(
                      content: Text("Debes subir una imágen"),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    try {
                      await firebase_storage.FirebaseStorage.instance
                          .ref('images/products/$current_image_file_name')
                          .putString(current_image_file_base64,
                              format: firebase_storage.PutStringFormat.dataUrl)
                          .then((firebase_storage.TaskSnapshot
                              task_snapshot) async {
                        FirebaseFirestore.instance.collection("products").add({
                          "name": _controller_name.text,
                          "description": _controller_description.text,
                          "price": int.parse(_controller_price.text),
                          "url": await task_snapshot.ref.getDownloadURL(),
                        }).then((result) {
                          is_editing = false;
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        });
                      });
                    } catch (e) {
                      print("Error: $e");
                    }
                  }
                } else {
                  FirebaseFirestore.instance
                      .collection("products")
                      .doc(widget.product!.id)
                      .update({
                    "name": _controller_name.text,
                    "description": _controller_description.text,
                    "price": int.parse(_controller_price.text),
                  }).then((result) {
                    is_editing = false;
                    Navigator.of(context).pop();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  open_file_picker() async {
    file_picker.FilePickerResult? result =
        await file_picker.FilePicker.platform.pickFiles(
      type: file_picker.FileType.custom,
      allowedExtensions: ['svg'],
    );

    if (result != null) {
      current_image_file_base64 =
          "data:image/svg+xml;base64,${base64Encode(result.files.first.bytes!)}";
      current_image_file_name = result.files.first.name;
      upload_image_button_label = current_image_file_name;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double textfield_size = 18;
    double title_size = 18;
    double subtitle_size = 16;

    return Scaffold(
      appBar: TopBar(
        background_color: color_lum_topbar,
        has_back_button: true,
        actions: [],
        custom_leading: null,
        logo_path: "assets/images/logo.png",
        logo_color: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: sized_box_space * 4,
                  ),
                  TextField(
                    onTap: () {
                      //
                    },
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color_lum_green,
                      fontSize: textfield_size,
                    ),
                    controller: _controller_name,
                    decoration: InputDecoration(
                      hintText: "Nombre",
                      hintStyle: TextStyle(
                        color: color_lum_green,
                        fontSize: textfield_size,
                      ),
                    ),
                    enabled: is_editing,
                  ),
                  SizedBox(
                    height: sized_box_space * 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "\$",
                          style: TextStyle(
                            color: color_lum_blue,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          onTap: () {
                            //
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: color_lum_blue,
                            fontSize: textfield_size,
                          ),
                          controller: _controller_price,
                          decoration: InputDecoration(
                            hintText: "Precio",
                            hintStyle: TextStyle(
                              color: color_lum_blue,
                              fontSize: textfield_size,
                            ),
                          ),
                          enabled: is_editing,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Spacer(flex: 1),
                      Expanded(
                        flex: 16,
                        child: CustomCard(
                          child: Container(
                            alignment: Alignment.center,
                            //margin: EdgeInsets.all(6),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              upload_image_button_label,
                              style: TextStyle(
                                color: color_lum_blue,
                              ),
                            ),
                          ),
                          elevation: 6,
                          border_radius: 10,
                          on_pressed: () {
                            if (is_editing) {
                              open_file_picker();
                            }
                          },
                          linear_gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                          splash_color: color_lum_blue.withOpacity(0.3),
                        ),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                  SizedBox(
                    height: sized_box_space * 2,
                  ),
                  TextField(
                    onTap: () {
                      //
                    },
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: color_lum_blue,
                      fontSize: textfield_size,
                    ),
                    controller: _controller_description,
                    decoration: InputDecoration(
                      hintText: "Descripción",
                      hintStyle: TextStyle(
                        color: color_lum_blue,
                        fontSize: textfield_size,
                      ),
                    ),
                    enabled: is_editing,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                  SizedBox(
                    height: sized_box_space * 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (is_editing) {
              show_save_data_alert_dialog(
                context: context,
              );
            } else {
              is_editing = true;
            }
          });
        },
        backgroundColor: color_lum_green,
        child: Icon(
          is_editing ? Icons.done : Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
