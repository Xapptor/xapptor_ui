import 'dart:async';
import 'package:xapptor_ui/widgets/background_image_with_gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xapptor_logic/is_portrait.dart';

class IntroductionContainer extends StatefulWidget {
  const IntroductionContainer({
    required this.texts,
    required this.text_color,
    required this.background_image,
    required this.logo_image,
    required this.scroll_icon,
    required this.scroll_icon_color,
    required this.height,
  });

  final List<String> texts;
  final Color text_color;
  final String background_image;
  final String? logo_image;
  final IconData scroll_icon;
  final Color scroll_icon_color;
  final double height;

  @override
  IntroductionContainerState createState() => IntroductionContainerState();
}

class IntroductionContainerState extends State<IntroductionContainer> {
  bool lower_the_icon = true;

  @override
  void initState() {
    super.initState();
    init_animation();
  }

  init_animation() {
    Timer(Duration(seconds: 3), () {
      lower_the_icon = !lower_the_icon;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);

    return Container(
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      child: BackgroundImageWithGradientColor(
        height: widget.height,
        box_fit: BoxFit.cover,
        image_path: widget.background_image,
        linear_gradient: LinearGradient(
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
          colors: [
            Colors.lightBlueAccent.withOpacity(0.0),
            Colors.blue.withOpacity(0.0),
          ],
          stops: [0.0, 1.0],
        ),
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Spacer(flex: 10),
                      widget.logo_image != null &&
                              (widget.texts.length > 1 ||
                                  (widget.texts.length == 1 && !portrait))
                          ? Expanded(
                              flex: 12,
                              child: Container(
                                //width: portrait ? 200 : 400,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage(
                                      widget.logo_image!,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Spacer(flex: 14),
                      Spacer(flex: 1),
                      Expanded(
                        flex: portrait ? 12 : 5,
                        child: FractionallySizedBox(
                          widthFactor: portrait ? 0.9 : 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: portrait ? 6 : 12,
                                child: SelectableText(
                                  widget.texts[0],
                                  toolbarOptions: ToolbarOptions(
                                    copy: true,
                                    paste: true,
                                    selectAll: true,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: widget.text_color,
                                    fontSize: portrait
                                        ? widget.texts.length > 1
                                            ? 28
                                            : 20
                                        : widget.texts.length > 1
                                            ? 36
                                            : 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              widget.texts.length > 1
                                  ? Spacer(flex: 2)
                                  : Container(),
                              widget.texts.length > 1
                                  ? Expanded(
                                      flex: portrait ? 4 : 10,
                                      child: SelectableText(
                                        widget.texts[1],
                                        toolbarOptions: ToolbarOptions(
                                          copy: true,
                                          paste: true,
                                          selectAll: true,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: widget.text_color,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              top: lower_the_icon ? 0 : 30,
                              width: MediaQuery.of(context).size.width,
                              curve: Curves.ease,
                              onEnd: () {
                                if (lower_the_icon) {
                                  Timer(Duration(seconds: 1), () {
                                    lower_the_icon = !lower_the_icon;
                                    setState(() {});
                                  });
                                } else {
                                  lower_the_icon = !lower_the_icon;
                                  setState(() {});
                                }
                              },
                              child: Icon(
                                widget.scroll_icon,
                                color: widget.scroll_icon_color,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
              /*Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: CurvePainter(),
              ),
            ),*/
            ],
          ),
        ),
      ),
    );
  }
}

/*class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
  var rect = Offset.zero & size;

    var paint = Paint();

    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blue,
        Colors.green,
      ],
    ).createShader(rect);

    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(size.width * 0.02, 0);
    path.quadraticBezierTo(size.width * 0.04, size.height * 0.25,
        size.width * 0.02, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.0, size.height * 0.75,
        size.width * 0.02, size.height * 1.0);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}*/
