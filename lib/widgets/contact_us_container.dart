import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xapptor_ui/widgets/url_launcher.dart';
import 'package:xapptor_ui/widgets/background_image_with_gradient_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'custom_card.dart';
import 'package:xapptor_ui/widgets/is_portrait.dart';

class ContactUsContainer extends StatefulWidget {
  const ContactUsContainer({
    super.key,
    required this.texts,
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

  final List<String> texts;
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
  State<ContactUsContainer> createState() => _ContactUsContainerState();
}

class _ContactUsContainerState extends State<ContactUsContainer> {
  TextEditingController name_input_controller = TextEditingController();
  TextEditingController email_input_controller = TextEditingController();
  TextEditingController subject_input_controller = TextEditingController();
  TextEditingController message_input_controller = TextEditingController();

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
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: SelectableText(
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
                child: SelectableText(
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
                        children: <Widget>[
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 10,
                            child: Column(
                              children: <Widget>[
                                portrait ? Container() : const Spacer(flex: 1),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: name_input_controller,
                                    decoration: InputDecoration(
                                      labelText: widget.texts[2],
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
                                    decoration: InputDecoration(
                                      labelText: widget.texts[3],
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
                                    controller: subject_input_controller,
                                    decoration: InputDecoration(
                                      labelText: widget.texts[4],
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
                                    controller: message_input_controller,
                                    decoration: InputDecoration(
                                      labelText: widget.texts[5],
                                    ),
                                    onSaved: (value) {},
                                    validator: (value) {
                                      return value!.contains('@') ? 'Do not use the @ char.' : null;
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FractionallySizedBox(
                                    heightFactor: portrait ? 0.5 : 0.5,
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
                                              if (name_input_controller.text.isNotEmpty &&
                                                  email_input_controller.text.isNotEmpty &&
                                                  subject_input_controller.text.isNotEmpty &&
                                                  message_input_controller.text.isNotEmpty) {
                                                String newMessage =
                                                    "${name_input_controller.text} has a message for you! \n\n Email: ${email_input_controller.text}\n\n Message: ${message_input_controller.text}";

                                                FirebaseFirestore.instance.collection("emails").doc().set({
                                                  "to": widget.email,
                                                  "message": {
                                                    "subject":
                                                        "Message from contact us section: \"${subject_input_controller.text}\"",
                                                    "text": newMessage,
                                                  }
                                                }).then((value) {
                                                  name_input_controller.clear();
                                                  email_input_controller.clear();
                                                  subject_input_controller.clear();
                                                  message_input_controller.clear();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: SelectableText(
                                                        widget.feedback_message,
                                                      ),
                                                      duration: const Duration(seconds: 2),
                                                    ),
                                                  );
                                                }).catchError((err) {
                                                  debugPrint(err);
                                                });
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: SelectableText(
                                                      widget.texts[10],
                                                    ),
                                                    duration: const Duration(seconds: 2),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                const Spacer(flex: 1),
                                                const Expanded(
                                                  flex: 5,
                                                  child: Icon(
                                                    FontAwesomeIcons.paperPlane,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                                const Spacer(flex: 1),
                                                Expanded(
                                                  flex: 7,
                                                  child: SelectableText(
                                                    widget.texts[6],
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(flex: 1),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Spacer(flex: portrait ? 1 : 9),
                                      ],
                                    ),
                                  ),
                                ),
                                portrait ? Container() : const Spacer(flex: 1),
                              ],
                            ),
                          ),
                          portrait ? Container() : const Spacer(flex: 1),
                          Expanded(
                            flex: portrait ? 10 : 4,
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
                                Expanded(
                                  flex: 3,
                                  child: SelectableText(
                                    widget.texts[7],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
                                Expanded(
                                  flex: 2,
                                  child: SelectableText(
                                    widget.texts[8],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
                                Expanded(
                                  flex: 4,
                                  child: SelectableText(
                                    widget.texts[9],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
                                                urls: [
                                                  widget.facebook_url!,
                                                  widget.facebook_url_fallback!,
                                                ],
                                                icon: FontAwesomeIcons.squareFacebook,
                                                icon_color: widget.icon_color,
                                              ),
                                            )
                                          : Container(),
                                      widget.youtube_url != null
                                          ? Expanded(
                                              flex: 5,
                                              child: custom_icon_button(
                                                urls: [
                                                  widget.youtube_url!,
                                                  widget.youtube_url!,
                                                ],
                                                icon: FontAwesomeIcons.youtube,
                                                icon_color: widget.icon_color,
                                              ),
                                            )
                                          : Container(),
                                      widget.instagram_url != null
                                          ? Expanded(
                                              flex: 5,
                                              child: custom_icon_button(
                                                urls: [
                                                  widget.instagram_url!,
                                                  widget.instagram_url!,
                                                ],
                                                icon: FontAwesomeIcons.instagram,
                                                icon_color: widget.icon_color,
                                              ),
                                            )
                                          : Container(),
                                      widget.twitter_url != null
                                          ? Expanded(
                                              flex: 5,
                                              child: custom_icon_button(
                                                urls: [
                                                  widget.twitter_url!,
                                                  widget.twitter_url!,
                                                ],
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

Widget custom_icon_button({
  required List<String> urls,
  required IconData icon,
  required Color icon_color,
}) {
  return CustomCard(
    splash_color: icon_color.withOpacity(0.3),
    linear_gradient: const LinearGradient(
      colors: [
        Colors.transparent,
        Colors.transparent,
      ],
    ),
    on_pressed: () async {
      launch_url(
        urls[0],
        urls[1],
      );
    },
    shape: BoxShape.circle,
    child: Icon(
      icon,
      color: icon_color,
    ),
  );
}
