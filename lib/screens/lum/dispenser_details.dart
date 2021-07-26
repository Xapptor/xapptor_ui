// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:xapptor_core/models/lum/dispenser.dart';
// import 'package:xapptor_core/models/lum/vending_machine.dart';
// import 'package:xapptor_core/values/custom_colors.dart';

// class DispenserDetails extends StatefulWidget {
//   const DispenserDetails({
//     required this.vending_machine,
//     required this.dispenser_index,
//     required this.color,
//   });

//   final VendingMachine vending_machine;
//   final int dispenser_index;
//   final Color color;

//   @override
//   _DispenserDetailsState createState() => _DispenserDetailsState();
// }

// class _DispenserDetailsState extends State<DispenserDetails> {
//   TextEditingController _controller_name = TextEditingController();
//   TextEditingController _controller_price = TextEditingController();
//   TextEditingController _controller_image = TextEditingController();
//   bool is_editing = false;
//   bool dispenser_is_enabled = true;

//   @override
//   void dispose() {
//     _controller_name.dispose();
//     _controller_price.dispose();
//     _controller_image.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     set_values();
//   }

//   set_values() {
//     _controller_name.text =
//         widget.vending_machine.dispensers[widget.dispenser_index].name;

//     _controller_price.text = widget
//         .vending_machine.dispensers[widget.dispenser_index].price
//         .toString();

//     _controller_image.text =
//         widget.vending_machine.dispensers[widget.dispenser_index].image;

//     dispenser_is_enabled =
//         widget.vending_machine.dispensers[widget.dispenser_index].enabled;
//   }

//   show_save_data_alert_dialog({
//     required BuildContext context,
//   }) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("¿Deseas guardar los cambios?"),
//           //content: Text(""),
//           actions: <Widget>[
//             TextButton(
//               child: Text("Descartar cambios"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text("Cancelar"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text("Aceptar"),
//               onPressed: () async {
//                 Dispenser updated_dispenser = Dispenser(
//                   name: _controller_name.text,
//                   image: _controller_image.text,
//                   price: int.parse(_controller_price.text),
//                   enabled: dispenser_is_enabled,
//                   quantity_remaining: widget.vending_machine
//                       .dispensers[widget.dispenser_index].quantity_remaining,
//                 );

//                 List<Dispenser> updated_dispensers =
//                     widget.vending_machine.dispensers;

//                 updated_dispensers[widget.dispenser_index] = updated_dispenser;

//                 List<Map<String, dynamic>> dispensers_map_list = [];

//                 for (var dispenser in updated_dispensers) {
//                   dispensers_map_list.add(
//                     dispenser.to_json(),
//                   );
//                 }

//                 FirebaseFirestore.instance
//                     .collection("vending_machines")
//                     .doc(widget.vending_machine.id)
//                     .update({
//                   "dispensers": dispensers_map_list,
//                 }).then((result) {
//                   is_editing = false;
//                   Navigator.of(context).pop();
//                 });
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double current_card_height = MediaQuery.of(context).size.height * 0.65;
//     double current_card_width = MediaQuery.of(context).size.width * 0.8;
//     double current_card_margin = MediaQuery.of(context).size.height * 0.015;
//     double current_card_padding = MediaQuery.of(context).size.width * 0.07;
//     double title_size = 16;
//     double subtitle_size = 14;
//     double current_opacity = 0.8;
//     //double sized_box_height = MediaQuery.of(context).size.height / 16;

//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Container(
//             height: current_card_height,
//             width: current_card_width,
//             margin: EdgeInsets.all(current_card_margin),
//             padding: EdgeInsets.all(current_card_padding),
//             decoration: BoxDecoration(
//               color: dispenser_is_enabled
//                   ? widget.color
//                   : Colors.grey.withOpacity(current_opacity),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(8),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 3,
//                   child: TextField(
//                     onTap: () {
//                       //
//                     },
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                     controller: _controller_name,
//                     decoration: InputDecoration(
//                       hintText: "Nombre",
//                       hintStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: subtitle_size,
//                       ),
//                     ),
//                     enabled: is_editing,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: TextField(
//                     onTap: () {
//                       //
//                     },
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                     controller: _controller_price,
//                     decoration: InputDecoration(
//                       hintText: "Precio",
//                       hintStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: subtitle_size,
//                       ),
//                     ),
//                     keyboardType: TextInputType.number,
//                     enabled: is_editing,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: TextField(
//                     onTap: () {
//                       //
//                     },
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                     controller: _controller_image,
//                     decoration: InputDecoration(
//                       hintText: "URL de Imágen",
//                       hintStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: subtitle_size,
//                       ),
//                     ),
//                     enabled: is_editing,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "Dispensador: ",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: title_size,
//                           ),
//                         ),
//                         TextSpan(
//                           text: widget.dispenser_index.toString(),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: subtitle_size,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Row(
//                     children: [
//                       RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text: "Habilitada: ",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 fontSize: title_size,
//                               ),
//                             ),
//                             TextSpan(
//                               text: dispenser_is_enabled.toString(),
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: subtitle_size,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Switch(
//                         value: dispenser_is_enabled,
//                         onChanged: is_editing
//                             ? (value) {
//                                 setState(() {
//                                   dispenser_is_enabled = value;
//                                 });
//                               }
//                             : null,
//                         activeTrackColor: color_lum_green,
//                         activeColor: color_lum_light_pink,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "Cantidad disponible: ",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: title_size,
//                           ),
//                         ),
//                         TextSpan(
//                           text: widget
//                               .vending_machine
//                               .dispensers[widget.dispenser_index]
//                               .quantity_remaining
//                               .toString(),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: subtitle_size,
//                           ),
//                         ),
//                         TextSpan(
//                           text: " Litros",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: subtitle_size,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               if (is_editing) {
//                 show_save_data_alert_dialog(
//                   context: context,
//                 );
//               } else {
//                 is_editing = true;
//               }
//             });
//           },
//           backgroundColor: color_lum_green,
//           child: Icon(
//             is_editing ? Icons.done : Icons.edit,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
