import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:xapptor_logic/url_launcher.dart';
import 'package:xapptor_ui/widgets/background_image_with_gradient_color.dart';
import 'package:flutter/material.dart';

class ContactUsContainerLeadForm extends StatefulWidget {
  const ContactUsContainerLeadForm({
    required this.landing_class,
    required this.icon_color,
    required this.container_background_color,
    required this.container_background_image,
    required this.card_background_color,
    required this.card_background_image,
    required this.facebook_url,
    required this.facebook_url_fallback,
    required this.youtube_url,
    required this.instagram_url,
    required this.twitter_url,
    required this.email,
    required this.feedback_message,
    required this.linear_gradient_colors,
  });

  final landing_class;
  final Color icon_color;
  final Color container_background_color;
  final String container_background_image;
  final Color card_background_color;
  final String card_background_image;
  final String? facebook_url;
  final String? facebook_url_fallback;
  final String? youtube_url;
  final String? instagram_url;
  final String? twitter_url;
  final String email;
  final String feedback_message;
  final List<Color> linear_gradient_colors;

  @override
  _ContactUsContainerLeadFormState createState() =>
      _ContactUsContainerLeadFormState();
}

class _ContactUsContainerLeadFormState
    extends State<ContactUsContainerLeadForm> {
  static List<String> insurance_type_values = [
    "¿Qué seguro te interesa?",
    "Seguro de Vida",
    "Protección de Hipoteca",
    "Gastos Funerarios",
  ];

  static List<String> schedule_values = [
    "¿A qué hora te gustaría que te llamaran?",
    "6 AM - 9 AM",
    "9 AM - 12 PM",
    "12 PM - 3 PM",
    "3 PM - 6 PM",
    "6 PM - 9 PM",
    "9 PM - 12 AM",
  ];

  String insurance_type_value = insurance_type_values[0];
  String schedule_value = schedule_values[0];

  TextEditingController name_input_controller = TextEditingController();
  TextEditingController address_input_controller = TextEditingController();
  TextEditingController zip_code_input_controller = TextEditingController();
  TextEditingController telephone_number_input_controller =
      TextEditingController();
  TextEditingController email_input_controller = TextEditingController();

  String birthday_label = "Fecha de Nacimiento";

  static DateTime over_18 = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
  static DateTime first_date = DateTime(
      DateTime.now().year - 150, DateTime.now().month, DateTime.now().day);
  DateTime selected_date = over_18;

  Future<Null> _select_date(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: selected_date,
      firstDate: first_date,
      lastDate: over_18,
    ));
    if (picked != null)
      setState(() {
        selected_date = picked;

        DateFormat date_formatter = DateFormat.yMMMMd('en_US');
        String date_now_formatted = date_formatter.format(selected_date);
        birthday_label = date_now_formatted;
      });
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      height: portrait
          ? (MediaQuery.of(context).size.height * 1.8)
          : (MediaQuery.of(context).size.height),
      width: MediaQuery.of(context).size.width,
      child: BackgroundImageWithGradientColor(
        height: portrait
            ? (MediaQuery.of(context).size.height * 1.8)
            : (MediaQuery.of(context).size.height),
        width: MediaQuery.of(context).size.width,
        box_fit: BoxFit.cover,
        background_image_path: widget.container_background_image,
        linear_gradient: LinearGradient(
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
          colors: widget.linear_gradient_colors,
          stops: [0.0, 1.0],
        ),
        child: Column(
          children: <Widget>[
            Spacer(flex: 1),
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Text(
                  "Contacto",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: portrait ? 2 : 1,
              child: FractionallySizedBox(
                widthFactor: 0.55,
                child: Text(
                  "Mandanos tu información para ofrecerte el mejor servicio",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: portrait ? 10 : 6,
              child: FractionallySizedBox(
                widthFactor: portrait ? 0.8 : 0.8,
                child: Card(
                  elevation: 5,
                  semanticContainer: true,
                  color: widget.card_background_color,
                  child: Container(
                    decoration: BoxDecoration(
                      image: widget.card_background_image.isNotEmpty
                          ? DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage(
                                widget.card_background_image,
                              ),
                            )
                          : null,
                      color: widget.card_background_color,
                    ),
                    child: FractionallySizedBox(
                      widthFactor: portrait ? 0.8 : 1,
                      child: Flex(
                        direction: portrait ? Axis.vertical : Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Spacer(flex: 1),
                          Expanded(
                            flex: 10,
                            child: Column(
                              children: <Widget>[
                                portrait ? Container() : Spacer(flex: 1),
                                Expanded(
                                  flex: portrait ? 30 : 8,
                                  child: Flex(
                                    direction: portrait
                                        ? Axis.vertical
                                        : Axis.horizontal,
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Spacer(flex: 2),
                                                  DropdownButton<String>(
                                                    isExpanded: true,
                                                    value: insurance_type_value,
                                                    iconSize: 24,
                                                    elevation: 16,
                                                    style: TextStyle(
                                                      color: widget.icon_color,
                                                    ),
                                                    underline: Container(
                                                      height: 1,
                                                      color: widget.icon_color,
                                                    ),
                                                    onChanged: (new_value) {
                                                      setState(() {
                                                        insurance_type_value =
                                                            new_value!;
                                                      });
                                                    },
                                                    items: insurance_type_values
                                                        .map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  Spacer(flex: 10),
                                                  DropdownButton<String>(
                                                    isExpanded: true,
                                                    value: schedule_value,
                                                    iconSize: 24,
                                                    elevation: 16,
                                                    style: TextStyle(
                                                      color: widget.icon_color,
                                                    ),
                                                    underline: Container(
                                                      height: 1,
                                                      color: widget.icon_color,
                                                    ),
                                                    onChanged: (new_value) {
                                                      setState(() {
                                                        schedule_value =
                                                            new_value!;
                                                      });
                                                    },
                                                    items: schedule_values.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  Spacer(flex: 8),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                controller:
                                                    name_input_controller,
                                                decoration: InputDecoration(
                                                  labelText: "Nombre completo",
                                                ),
                                                onSaved: (value) {},
                                                validator: (value) {
                                                  return value!.contains('@')
                                                      ? 'Do not use the @ char.'
                                                      : null;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                controller:
                                                    address_input_controller,
                                                decoration: InputDecoration(
                                                  labelText: "Dirección",
                                                ),
                                                onSaved: (value) {},
                                                validator: (value) {
                                                  return value!.contains('@')
                                                      ? 'Do not use the @ char.'
                                                      : null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(flex: 1),
                                      Expanded(
                                        flex: 10,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                controller:
                                                    zip_code_input_controller,
                                                decoration: InputDecoration(
                                                  labelText: "Código postal",
                                                ),
                                                onSaved: (value) {},
                                                validator: (value) {
                                                  return value!.contains('@')
                                                      ? 'Do not use the @ char.'
                                                      : null;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                controller:
                                                    telephone_number_input_controller,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      "Número de teléfono",
                                                ),
                                                onSaved: (value) {},
                                                validator: (value) {
                                                  return value!.contains('@')
                                                      ? 'Do not use the @ char.'
                                                      : null;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                controller:
                                                    email_input_controller,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      "Correo electrónico",
                                                ),
                                                onSaved: (value) {},
                                                validator: (value) {
                                                  return value!.contains('@')
                                                      ? 'Do not use the @ char.'
                                                      : null;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: TextButton(
                                                  onPressed: () {
                                                    _select_date(context);
                                                  },
                                                  child: Text(
                                                    birthday_label,
                                                    style: TextStyle(
                                                      color: widget.icon_color,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                !portrait ? Container() : Spacer(flex: 1),
                                Expanded(
                                  flex: portrait ? 3 : 1,
                                  child: Row(
                                    children: <Widget>[
                                      portrait ? Spacer(flex: 1) : Container(),
                                      Expanded(
                                        flex: 2,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(widget.icon_color),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (insurance_type_value !=
                                                    "¿Qué seguro te interesa?" &&
                                                schedule_value !=
                                                    "¿A qué hora te gustaría que te llamaran?" &&
                                                birthday_label !=
                                                    "Fecha de Nacimiento") {
                                              String newMessage =
                                                  name_input_controller.text +
                                                      " has a message for you! \n\n" +
                                                      "You have a new Lead: \n\n " +
                                                      "Insurance Type: " +
                                                      insurance_type_value +
                                                      "\n" +
                                                      "Schedule: " +
                                                      schedule_value +
                                                      "\n" +
                                                      "Name: " +
                                                      name_input_controller
                                                          .text +
                                                      "\n" +
                                                      "Address: " +
                                                      address_input_controller
                                                          .text +
                                                      "\n" +
                                                      "Zip Code: " +
                                                      zip_code_input_controller
                                                          .text +
                                                      "\n" +
                                                      "Telephone Number: " +
                                                      telephone_number_input_controller
                                                          .text +
                                                      "\n" +
                                                      "Email: " +
                                                      email_input_controller
                                                          .text +
                                                      "\n" +
                                                      "Date of Birth: " +
                                                      birthday_label;

                                              FirebaseFirestore.instance
                                                  .collection("emails")
                                                  .doc()
                                                  .set({
                                                "to": widget.email,
                                                "message": {
                                                  "subject":
                                                      "You have a new Lead: " +
                                                          name_input_controller
                                                              .text,
                                                  "text": newMessage,
                                                  //"html": 'This is the <code>HTML</code> section of the email body.',
                                                }
                                              }).then((value) {
                                                insurance_type_value =
                                                    insurance_type_values[0];
                                                schedule_value =
                                                    schedule_values[0];
                                                name_input_controller.clear();
                                                address_input_controller
                                                    .clear();
                                                zip_code_input_controller
                                                    .clear();
                                                telephone_number_input_controller
                                                    .clear();
                                                email_input_controller.clear();
                                                birthday_label =
                                                    "Fecha de Nacimiento";

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    widget.feedback_message,
                                                  ),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ));

                                                setState(() {});
                                              }).catchError((err) {
                                                print(err);
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  "Debes seleccionar seguro de interés, horario de contacto y fecha de nacimiento",
                                                ),
                                                duration: Duration(seconds: 2),
                                              ));
                                            }
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Spacer(flex: 1),
                                              Expanded(
                                                flex: 5,
                                                child: Icon(
                                                  FontAwesome.paper_plane,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                              Spacer(flex: 1),
                                              Expanded(
                                                flex: 7,
                                                child: Text(
                                                  "Enviar",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    //fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Spacer(flex: 1),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(flex: portrait ? 1 : 9),
                                    ],
                                  ),
                                ),
                                portrait ? Container() : Spacer(flex: 1),
                              ],
                            ),
                          ),
                          portrait ? Container() : Spacer(flex: 1),
                          Expanded(
                            flex: portrait ? 5 : 4,
                            child: Column(
                              children: <Widget>[
                                Spacer(flex: portrait ? 1 : 4),
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.location_on,
                                    color: widget.icon_color,
                                  ),
                                ),
                                Spacer(flex: 1),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Miami, FL, U.S.A.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(flex: 2),
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.phone,
                                    color: widget.icon_color,
                                  ),
                                ),
                                Spacer(flex: 1),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "+1 (954) 995-9592",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(flex: 2),
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.email,
                                    color: widget.icon_color,
                                  ),
                                ),
                                Spacer(flex: 1),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "community-mgmt@abeinstitute.com",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(flex: 1),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: <Widget>[
                                      Spacer(flex: 1),
                                      widget.facebook_url != null
                                          ? Expanded(
                                              flex: 5,
                                              child: IconButton(
                                                onPressed: () async {
                                                  launch_url(
                                                    widget.facebook_url!,
                                                    widget
                                                        .facebook_url_fallback!,
                                                  );
                                                },
                                                icon: Icon(
                                                  FontAwesome.facebook_squared,
                                                  color: widget.icon_color,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      widget.youtube_url != null
                                          ? Expanded(
                                              flex: 5,
                                              child: IconButton(
                                                onPressed: () async {
                                                  launch_url(
                                                    widget.youtube_url!,
                                                    widget.youtube_url!,
                                                  );
                                                },
                                                icon: Icon(
                                                  FontAwesome.youtube_play,
                                                  color: widget.icon_color,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      widget.instagram_url != null
                                          ? Expanded(
                                              flex: 5,
                                              child: IconButton(
                                                onPressed: () async {
                                                  launch_url(
                                                    widget.instagram_url!,
                                                    widget.instagram_url!,
                                                  );
                                                },
                                                icon: Icon(
                                                  FontAwesome.instagram,
                                                  color: widget.icon_color,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      widget.twitter_url != null
                                          ? Expanded(
                                              flex: 5,
                                              child: IconButton(
                                                onPressed: () async {
                                                  launch_url(
                                                    widget.twitter_url!,
                                                    widget.twitter_url!,
                                                  );
                                                },
                                                icon: Icon(
                                                  FontAwesome.twitter,
                                                  color: widget.icon_color,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      Spacer(flex: 1),
                                    ],
                                  ),
                                ),
                                portrait ? Container() : Spacer(flex: 6),
                              ],
                            ),
                          ),
                          Spacer(flex: 1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
