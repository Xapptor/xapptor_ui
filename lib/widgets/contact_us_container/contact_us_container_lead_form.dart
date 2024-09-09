import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:xapptor_ui/widgets/by_layer/background_image_with_gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:xapptor_ui/widgets/card/custom_card.dart';
import 'package:xapptor_ui/utils/is_portrait.dart';
import 'package:xapptor_ui/widgets/contact_us_container/custom_icon_buttons.dart';
import 'package:xapptor_ui/widgets/contact_us_container/selectable_texts_abeinsurance.dart';
import 'package:xapptor_ui/widgets/contact_us_container/send_button_abeinsurance.dart';

class ContactUsContainerLeadForm extends StatefulWidget {
  final List<String> texts;
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

  const ContactUsContainerLeadForm({
    super.key,
    required this.texts,
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

  @override
  State<ContactUsContainerLeadForm> createState() => ContactUsContainerLeadFormState();
}

class ContactUsContainerLeadFormState extends State<ContactUsContainerLeadForm> {
  List<String> insurance_type_values = [
    "¿Qué seguro te interesa?",
    "Seguro de Vida",
    "Protección de Hipoteca",
    "Gastos Funerarios",
  ];

  List<String> schedule_values = [
    "¿A qué hora te gustaría que te llamaran?",
    "6 AM - 9 AM",
    "9 AM - 12 PM",
    "12 PM - 3 PM",
    "3 PM - 6 PM",
    "6 PM - 9 PM",
    "9 PM - 12 AM",
  ];

  late String insurance_type_value;
  late String schedule_value;

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
  void initState() {
    insurance_type_value = insurance_type_values[0];
    schedule_value = schedule_values[0];
    super.initState();
  }

  TextEditingController name_input_controller = TextEditingController();
  TextEditingController address_input_controller = TextEditingController();
  TextEditingController zip_code_input_controller = TextEditingController();
  TextEditingController telephone_number_input_controller = TextEditingController();
  TextEditingController email_input_controller = TextEditingController();

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
          children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Text(
                  widget.texts[0],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: portrait ? 2 : 1,
              child: FractionallySizedBox(
                widthFactor: 0.55,
                child: Text(
                  widget.texts[1],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
                        children: [
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 10,
                            child: Column(
                              children: [
                                if (!portrait) const Spacer(flex: 1),
                                Expanded(
                                  flex: portrait ? 30 : 8,
                                  child: Flex(
                                    direction: portrait ? Axis.vertical : Axis.horizontal,
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: Column(
                                          children: [
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
                                          children: [
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
                                if (portrait) const Spacer(flex: 1),
                                Expanded(
                                  flex: portrait ? 3 : 1,
                                  child: Row(
                                    children: [
                                      if (portrait) const Spacer(flex: 1),
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
                                          on_pressed: () => send_button(),
                                          child: const Row(
                                            children: [
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
                                if (!portrait) const Spacer(flex: 1),
                              ],
                            ),
                          ),
                          if (!portrait) const Spacer(flex: 1),
                          Expanded(
                            flex: portrait ? 10 : 4,
                            child: Column(
                              children: <Widget>[Spacer(flex: portrait ? 1 : 4)] +
                                  selectable_texts() +
                                  [
                                    const Spacer(flex: 1),
                                    Expanded(
                                      flex: 3,
                                      child: custom_icon_buttons(
                                        facebook_url: widget.facebook_url,
                                        facebook_url_fallback: widget.facebook_url_fallback,
                                        youtube_url: widget.youtube_url,
                                        instagram_url: widget.instagram_url,
                                        twitter_url: widget.twitter_url,
                                        icon_color: widget.icon_color,
                                      ),
                                    ),
                                    if (!portrait) const Spacer(flex: 6),
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
