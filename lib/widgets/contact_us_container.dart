import 'package:fluttericon/font_awesome_icons.dart';
import 'package:xapptor_logic/url_launcher.dart';
import 'package:xapptor_ui/widgets/background_image_with_gradient_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactUsContainer extends StatefulWidget {
  const ContactUsContainer({
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
  });

  final List<String> texts;
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
  _ContactUsContainerState createState() => _ContactUsContainerState();
}

class _ContactUsContainerState extends State<ContactUsContainer> {
  TextEditingController name_input_controller = TextEditingController();
  TextEditingController email_input_controller = TextEditingController();
  TextEditingController subject_input_controller = TextEditingController();
  TextEditingController message_input_controller = TextEditingController();

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
                  widget.texts[0],
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
              child: FractionallySizedBox(
                widthFactor: 0.55,
                child: Text(
                  widget.texts[1],
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
                                  flex: 1,
                                  child: TextFormField(
                                    controller: name_input_controller,
                                    decoration: InputDecoration(
                                      hintText: 'What do people call you?',
                                      labelText: widget.texts[2],
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
                                    controller: email_input_controller,
                                    decoration: InputDecoration(
                                      labelText: widget.texts[3],
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
                                    controller: subject_input_controller,
                                    decoration: InputDecoration(
                                      labelText: widget.texts[4],
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
                                    controller: message_input_controller,
                                    decoration: InputDecoration(
                                      labelText: widget.texts[5],
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
                                            String newMessage =
                                                name_input_controller.text +
                                                    " has a message for you! \n\n Email: " +
                                                    email_input_controller
                                                        .text +
                                                    "\n\n Message: " +
                                                    message_input_controller
                                                        .text;

                                            FirebaseFirestore.instance
                                                .collection("emails")
                                                .doc()
                                                .set({
                                              "to": widget.email,
                                              "message": {
                                                "subject":
                                                    "Message from contact us section: " +
                                                        '"' +
                                                        subject_input_controller
                                                            .text +
                                                        '"',
                                                "text": newMessage,
                                              }
                                            }).then((value) {
                                              name_input_controller.clear();
                                              email_input_controller.clear();
                                              subject_input_controller.clear();
                                              message_input_controller.clear();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    widget.feedback_message,
                                                  ),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            }).catchError((err) {
                                              print(err);
                                            });
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
                                                  widget.texts[6],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
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
                                Spacer(flex: 1),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    widget.texts[7],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
                                    widget.texts[8],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
                                    widget.texts[9],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
