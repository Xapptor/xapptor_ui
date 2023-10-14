import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:xapptor_ui/widgets/background_image_with_gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/contact_us_container/custom_icon_button.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';
import 'custom_card.dart';

class ContactUsContainerLeadForm extends StatefulWidget {
  const ContactUsContainerLeadForm({
    super.key,
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
    this.border_radius = 0,
  });

  // ignore: prefer_typing_uninitialized_variables
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
  final double border_radius;

  @override
  State<ContactUsContainerLeadForm> createState() => _ContactUsContainerLeadFormState();
}

class _ContactUsContainerLeadFormState extends State<ContactUsContainerLeadForm> {
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
  TextEditingController telephone_number_input_controller = TextEditingController();
  TextEditingController email_input_controller = TextEditingController();

  String birthday_label = "Fecha de Nacimiento";

  static DateTime over_18 = DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
  static DateTime first_date = DateTime(DateTime.now().year - 150, DateTime.now().month, DateTime.now().day);
  DateTime selected_date = over_18;

  Future _select_date(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: selected_date,
      firstDate: first_date,
      lastDate: over_18,
    ));
    if (picked != null) {
      setState(() {
        selected_date = picked;

        DateFormat date_formatter = DateFormat.yMMMMd('en_US');
        String date_now_formatted = date_formatter.format(selected_date);
        birthday_label = date_now_formatted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);

    double height = portrait ? (MediaQuery.of(context).size.height * 2) : (MediaQuery.of(context).size.height);

    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: BackgroundImageWithGradientColor(
        height: height,
        box_fit: BoxFit.cover,
        image_path: widget.container_background_image,
        linear_gradient: LinearGradient(
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
          colors: widget.linear_gradient_colors,
          stops: const [0.0, 1.0],
        ),
        child: Column(
          children: <Widget>[
            const Spacer(flex: 1),
            const Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Text(
                  "Contacto",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: portrait ? 2 : 1,
              child: const FractionallySizedBox(
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.border_radius),
                  ),
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
                      borderRadius: BorderRadius.circular(widget.border_radius),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: portrait ? 0.8 : 1,
                      child: Flex(
                        direction: portrait ? Axis.vertical : Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 10,
                            child: Column(
                              children: <Widget>[
                                portrait ? Container() : const Spacer(flex: 1),
                                Expanded(
                                  flex: portrait ? 30 : 8,
                                  child: Flex(
                                    direction: portrait ? Axis.vertical : Axis.horizontal,
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Spacer(flex: 2),
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
                                                        insurance_type_value = new_value!;
                                                      });
                                                    },
                                                    items: insurance_type_values
                                                        .map<DropdownMenuItem<String>>((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  const Spacer(flex: 10),
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
                                                        schedule_value = new_value!;
                                                      });
                                                    },
                                                    items:
                                                        schedule_values.map<DropdownMenuItem<String>>((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  const Spacer(flex: 8),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                controller: name_input_controller,
                                                decoration: const InputDecoration(
                                                  labelText: "Nombre completo",
                                                ),
                                                onSaved: (value) {},
                                                validator: (value) {
                                                  return value!.contains('@') ? 'Do not use the @ char.' : null;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                controller: address_input_controller,
                                                decoration: const InputDecoration(
                                                  labelText: "Dirección",
                                                ),
                                                onSaved: (value) {},
                                                validator: (value) {
                                                  return value!.contains('@') ? 'Do not use the @ char.' : null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(flex: 1),
                                      Expanded(
                                        flex: 10,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                controller: zip_code_input_controller,
                                                decoration: const InputDecoration(
                                                  labelText: "Código postal",
                                                ),
                                                onSaved: (value) {},
                                                validator: (value) {
                                                  return value!.contains('@') ? 'Do not use the @ char.' : null;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                controller: telephone_number_input_controller,
                                                decoration: const InputDecoration(
                                                  labelText: "Número de teléfono",
                                                ),
                                                onSaved: (value) {},
                                                validator: (value) {
                                                  return value!.contains('@') ? 'Do not use the @ char.' : null;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                controller: email_input_controller,
                                                decoration: const InputDecoration(
                                                  labelText: "Correo electrónico",
                                                ),
                                                onSaved: (value) {},
                                                validator: (value) {
                                                  return value!.contains('@') ? 'Do not use the @ char.' : null;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width,
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
                                !portrait ? Container() : const Spacer(flex: 1),
                                Expanded(
                                  flex: portrait ? 3 : 1,
                                  child: Row(
                                    children: <Widget>[
                                      portrait ? const Spacer(flex: 1) : Container(),
                                      Expanded(
                                        flex: 2,
                                        child: CustomCard(
                                          linear_gradient: LinearGradient(
                                            colors: [
                                              widget.icon_color,
                                              widget.icon_color,
                                            ],
                                          ),
                                          border_radius: 1000,
                                          on_pressed: () {
                                            if (insurance_type_value != "¿Qué seguro te interesa?" &&
                                                schedule_value != "¿A qué hora te gustaría que te llamaran?" &&
                                                birthday_label != "Fecha de Nacimiento") {
                                              String newMessage =
                                                  "${name_input_controller.text} has a message for you! \n\nYou have a new Lead: \n\n Insurance Type: $insurance_type_value\nSchedule: $schedule_value\nName: ${name_input_controller.text}\nAddress: ${address_input_controller.text}\nZip Code: ${zip_code_input_controller.text}\nTelephone Number: ${telephone_number_input_controller.text}\nEmail: ${email_input_controller.text}\nDate of Birth: $birthday_label";

                                              FirebaseFirestore.instance.collection("emails").doc().set({
                                                "to": widget.email,
                                                "message": {
                                                  "subject": "You have a new Lead: ${name_input_controller.text}",
                                                  "text": newMessage,
                                                }
                                              }).then((value) {
                                                insurance_type_value = insurance_type_values[0];
                                                schedule_value = schedule_values[0];
                                                name_input_controller.clear();
                                                address_input_controller.clear();
                                                zip_code_input_controller.clear();
                                                telephone_number_input_controller.clear();
                                                email_input_controller.clear();
                                                birthday_label = "Fecha de Nacimiento";

                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  content: Text(
                                                    widget.feedback_message,
                                                  ),
                                                  duration: const Duration(seconds: 2),
                                                ));

                                                setState(() {});
                                              }).catchError((err) {
                                                debugPrint(err);
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content: Text(
                                                  "Debes seleccionar seguro de interés, horario de contacto y fecha de nacimiento",
                                                ),
                                                duration: Duration(seconds: 2),
                                              ));
                                            }
                                          },
                                          child: const Row(
                                            children: <Widget>[
                                              Spacer(flex: 1),
                                              Expanded(
                                                flex: 5,
                                                child: Icon(
                                                  FontAwesomeIcons.paperPlane,
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
                                portrait ? Container() : const Spacer(flex: 1),
                              ],
                            ),
                          ),
                          portrait ? Container() : const Spacer(flex: 1),
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
                                const Spacer(flex: 1),
                                const Expanded(
                                  flex: 3,
                                  child: SelectableText(
                                    "Miami, FL, U.S.A.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(flex: 2),
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.phone,
                                    color: widget.icon_color,
                                  ),
                                ),
                                const Spacer(flex: 1),
                                const Expanded(
                                  flex: 2,
                                  child: SelectableText(
                                    "+1 (954) 995-9592",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(flex: 2),
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.email,
                                    color: widget.icon_color,
                                  ),
                                ),
                                const Spacer(flex: 1),
                                const Expanded(
                                  flex: 4,
                                  child: SelectableText(
                                    "it-support@abeinstitute.com",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(flex: 1),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: <Widget>[
                                      const Spacer(flex: 1),
                                      widget.facebook_url != null
                                          ? Expanded(
                                              flex: 5,
                                              child: custom_icon_button(
                                                urls: [widget.facebook_url!, widget.facebook_url_fallback!],
                                                icon: FontAwesomeIcons.squareFacebook,
                                                icon_color: widget.icon_color,
                                              ),
                                            )
                                          : Container(),
                                      widget.youtube_url != null
                                          ? Expanded(
                                              flex: 5,
                                              child: custom_icon_button(
                                                urls: [widget.youtube_url!, widget.youtube_url!],
                                                icon: FontAwesomeIcons.youtube,
                                                icon_color: widget.icon_color,
                                              ),
                                            )
                                          : Container(),
                                      widget.instagram_url != null
                                          ? Expanded(
                                              flex: 5,
                                              child: custom_icon_button(
                                                urls: [widget.instagram_url!, widget.instagram_url!],
                                                icon: FontAwesomeIcons.instagram,
                                                icon_color: widget.icon_color,
                                              ),
                                            )
                                          : Container(),
                                      widget.twitter_url != null
                                          ? Expanded(
                                              flex: 5,
                                              child: custom_icon_button(
                                                urls: [widget.twitter_url!, widget.twitter_url!],
                                                icon: FontAwesomeIcons.twitter,
                                                icon_color: widget.icon_color,
                                              ),
                                            )
                                          : Container(),
                                      const Spacer(flex: 1),
                                    ],
                                  ),
                                ),
                                portrait ? Container() : const Spacer(flex: 6),
                              ],
                            ),
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
