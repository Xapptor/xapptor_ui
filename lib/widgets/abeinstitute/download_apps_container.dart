import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';

class DownloadAppsContainer extends StatefulWidget {
  const DownloadAppsContainer({
    required this.texts,
    required this.background_image,
    required this.background_color,
    required this.title_color,
    required this.subtitle_color,
    required this.image_1,
    required this.image_2,
    required this.android_url,
    required this.ios_url,
  });

  final List<String> texts;
  final String background_image;
  final Color background_color;
  final Color title_color;
  final Color subtitle_color;
  final String image_1;
  final String image_2;
  final String android_url;
  final String ios_url;

  @override
  _DownloadAppsContainerState createState() => _DownloadAppsContainerState();
}

class _DownloadAppsContainerState extends State<DownloadAppsContainer> {
  double current_page = 0;
  final PageController page_controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    var widgets_list = <Widget>[
      Spacer(flex: 2),
      Expanded(
        flex: portrait ? 6 : 4,
        child: Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                  widget.image_1,
                ),
              ),
            ),
          ),
        ),
      ),
      Spacer(flex: 1),
      Expanded(
        flex: 4,
        child: Column(
          children: <Widget>[
            Spacer(flex: 1),
            Expanded(
              flex: portrait ? 4 : 1,
              child: Text(
                widget.texts[2],
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: widget.subtitle_color,
                  fontSize: 22,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
      Spacer(flex: 2),
    ];

    return Container(
      decoration: BoxDecoration(
        image: widget.background_image.isNotEmpty
            ? DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(
                  widget.background_image,
                ),
              )
            : null,
        color: widget.background_color,
      ),
      height: portrait
          ? (MediaQuery.of(context).size.height * 2)
          : (MediaQuery.of(context).size.height),
      child: FractionallySizedBox(
        widthFactor: portrait ? 0.8 : 1,
        child: Column(
          children: <Widget>[
            portrait ? Container() : Spacer(flex: 1),
            Expanded(
              flex: 2,
              child: AutoSizeText(
                widget.texts[0],
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: widget.title_color,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                minFontSize: 30,
                maxLines: 4,
                overflow: TextOverflow.clip,
              ),
            ),
            portrait ? Container() : Spacer(flex: 1),
            Expanded(
              flex: 6,
              child: Flex(
                  direction: portrait ? Axis.vertical : Axis.horizontal,
                  children: <Widget>[
                    Spacer(flex: 2),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: <Widget>[
                          Spacer(flex: 1),
                          Expanded(
                            flex: portrait ? 4 : 1,
                            child: Text(
                              widget.texts[1],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: widget.subtitle_color,
                                fontSize: 22,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(flex: 1),
                        ],
                      ),
                    ),
                    Spacer(flex: 1),
                    Expanded(
                      flex: portrait ? 6 : 4,
                      child: Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage(
                                widget.image_2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(flex: 2),
                  ]),
            ),
            portrait ? Container() : Spacer(flex: 1),
            Expanded(
              flex: 6,
              child: Flex(
                direction: portrait ? Axis.vertical : Axis.horizontal,
                children:
                    portrait ? widgets_list.reversed.toList() : widgets_list,
              ),
            ),
            portrait ? Container() : Spacer(flex: 1),
            Expanded(
              flex: 6,
              child: Flex(
                direction: portrait ? Axis.vertical : Axis.horizontal,
                children: <Widget>[
                  Spacer(flex: 2),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: <Widget>[
                        portrait ? Container() : Spacer(flex: 1),
                        Expanded(
                          flex: portrait ? 20 : 1,
                          child: Text(
                            widget.texts[3],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: widget.subtitle_color,
                              fontSize: 22,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                      ],
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: portrait ? 6 : 4,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 8,
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Coming soon 👍"),
                                duration: Duration(seconds: 1),
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage(
                                    'assets/images/mobile_stores/google_badge_en.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Coming soon 👍"),
                                duration: Duration(seconds: 1),
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage(
                                    'assets/images/mobile_stores/apple_badge_en.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
            portrait ? Container() : Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
