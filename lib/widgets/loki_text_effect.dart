import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xapptor_ui/utils/is_portrait.dart';
import 'package:xapptor_ui/utils/random_number_with_range.dart';
import 'dart:async';

class LokiTextEffect extends StatefulWidget {
  final List<String> introduction_texts;
  final Color text_color;
  final double text_blur_radius;
  final bool uniform_effect;

  const LokiTextEffect({
    super.key,
    required this.introduction_texts,
    required this.text_color,
    required this.text_blur_radius,
    this.uniform_effect = true,
  });

  @override
  State<LokiTextEffect> createState() => _LokiTextEffectState();
}

class _LokiTextEffectState extends State<LokiTextEffect> {
  Timer? timer_introduction_text;
  Timer? timer_font_family;
  List<String> font_families = default_loki_font_families;
  String current_text = "";

  @override
  void dispose() {
    if (timer_introduction_text != null) timer_introduction_text!.cancel();
    if (timer_font_family != null) timer_font_family!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    current_text = widget.introduction_texts[random_number_with_range(0, widget.introduction_texts.length - 1)];
    super.initState();

    timer_introduction_text = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        update_current_introduction_text();
      },
    );

    if (widget.uniform_effect) {
      timer_font_family = Timer.periodic(
        const Duration(milliseconds: 500),
        (timer) {
          setState(() {});
        },
      );
    }
  }

  update_current_introduction_text() {
    current_text = widget.introduction_texts[random_number_with_range(0, widget.introduction_texts.length - 1)];

    int random_number = random_number_with_range(0, 20);
    current_text = current_text.split('').join(' ');

    if (random_number >= 1 && random_number <= 2) {
      current_text += "  !";
    } else if (random_number >= 3 && random_number <= 4) {
      current_text += "  ;)";
    } else if (random_number >= 17 && random_number <= 18) {
      current_text += "  :O";
    } else if (random_number >= 19 && random_number <= 20) {
      current_text += "  :D";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        current_text.length,
        (index) {
          return LokiTextEffectChar(
            char: current_text[index],
            font_families: font_families,
            text_color: widget.text_color,
            text_blur_radius: widget.text_blur_radius,
            uniform_effect: widget.uniform_effect,
          );
        },
      ),
    );
  }
}

class LokiTextEffectChar extends StatefulWidget {
  final String char;
  final List<String> font_families;
  final Color text_color;
  final double text_blur_radius;
  final bool uniform_effect;

  const LokiTextEffectChar({
    super.key,
    required this.char,
    required this.font_families,
    required this.text_color,
    required this.text_blur_radius,
    required this.uniform_effect,
  });

  @override
  State<LokiTextEffectChar> createState() => _LokiTextEffectCharState();
}

class _LokiTextEffectCharState extends State<LokiTextEffectChar> {
  Timer? timer_font_family;
  String current_font_family = "";

  @override
  void initState() {
    current_font_family = widget.font_families[random_number_with_range(0, widget.font_families.length - 1)];

    super.initState();

    if (!widget.uniform_effect) {
      timer_font_family = Timer.periodic(
        Duration(milliseconds: random_number_with_range(1200, 2500)),
        (timer) {
          current_font_family = widget.font_families[random_number_with_range(0, widget.font_families.length - 1)];
          setState(() {});
        },
      );
    }
  }

  @override
  void dispose() {
    if (timer_font_family != null) timer_font_family!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait = is_portrait(context);

    if (widget.uniform_effect) {
      current_font_family = widget.font_families[random_number_with_range(0, widget.font_families.length - 1)];
    }

    TextStyle text_style = TextStyle(
      shadows: [
        Shadow(
          blurRadius: widget.text_blur_radius,
          color: widget.text_color,
          offset: Offset.zero,
        ),
      ],
      color: widget.text_color,
      fontSize: portrait ? 22 : 38,
      fontFamily: current_font_family,
      fontWeight: FontWeight.bold,
    );

    String char = widget.char;
    if (random_number_with_range(0, 10) == 0) {
      char = char.toUpperCase();
    }
    return Text(
      char,
      textAlign: TextAlign.center,
      style: text_style,
    );
  }
}

List<String> default_loki_font_families = [
  GoogleFonts.babylonica().fontFamily!,
  GoogleFonts.ballet().fontFamily!,
  GoogleFonts.bangers().fontFamily!,
  GoogleFonts.bonbon().fontFamily!,
  GoogleFonts.bungeeOutline().fontFamily!,
  GoogleFonts.bungeeShade().fontFamily!,
  GoogleFonts.caesarDressing().fontFamily!,
  GoogleFonts.caveat().fontFamily!,
  GoogleFonts.cevicheOne().fontFamily!,
  GoogleFonts.charmonman().fontFamily!,
  GoogleFonts.cinzel().fontFamily!,
  GoogleFonts.comforter().fontFamily!,
  GoogleFonts.cookie().fontFamily!,
  GoogleFonts.damion().fontFamily!,
  GoogleFonts.dancingScript().fontFamily!,
  GoogleFonts.diplomata().fontFamily!,
  GoogleFonts.diplomataSc().fontFamily!,
  GoogleFonts.dokdo().fontFamily!,
  GoogleFonts.domine().fontFamily!,
  GoogleFonts.ewert().fontFamily!,
  GoogleFonts.flowRounded().fontFamily!,
  GoogleFonts.fontdinerSwanky().fontFamily!,
  GoogleFonts.gabriela().fontFamily!,
  GoogleFonts.greatVibes().fontFamily!,
  GoogleFonts.honk().fontFamily!,
  GoogleFonts.inconsolata().fontFamily!,
  GoogleFonts.italianno().fontFamily!,
  GoogleFonts.jaldi().fontFamily!,
  GoogleFonts.jetBrainsMono().fontFamily!,
  GoogleFonts.kadwa().fontFamily!,
  GoogleFonts.kalam().fontFamily!,
  GoogleFonts.kumarOne().fontFamily!,
  GoogleFonts.libreBarcode128Text().fontFamily!,
  GoogleFonts.meowScript().fontFamily!,
  GoogleFonts.micro5().fontFamily!,
  GoogleFonts.moiraiOne().fontFamily!,
  GoogleFonts.mogra().fontFamily!,
  GoogleFonts.molle().fontFamily!,
  GoogleFonts.monofett().fontFamily!,
  GoogleFonts.monoton().fontFamily!,
  GoogleFonts.monsieurLaDoulaise().fontFamily!,
  GoogleFonts.montserratSubrayada().fontFamily!,
  GoogleFonts.mooLahLah().fontFamily!,
  GoogleFonts.mrsSheppards().fontFamily!,
  GoogleFonts.mynerve().fontFamily!,
  GoogleFonts.mySoul().fontFamily!,
  GoogleFonts.neonderthaw().fontFamily!,
  GoogleFonts.notable().fontFamily!,
  GoogleFonts.nothingYouCouldDo().fontFamily!,
  GoogleFonts.odorMeanChey().fontFamily!,
  GoogleFonts.oi().fontFamily!,
  GoogleFonts.permanentMarker().fontFamily!,
  GoogleFonts.pinyonScript().fontFamily!,
  GoogleFonts.pixelifySans().fontFamily!,
  GoogleFonts.protestGuerrilla().fontFamily!,
  GoogleFonts.protestRevolution().fontFamily!,
  GoogleFonts.quattrocentoSans().fontFamily!,
  GoogleFonts.racingSansOne().fontFamily!,
  GoogleFonts.righteous().fontFamily!,
  GoogleFonts.rockSalt().fontFamily!,
  GoogleFonts.rubikMaps().fontFamily!,
  GoogleFonts.rubikMicrobe().fontFamily!,
  GoogleFonts.rubikPixels().fontFamily!,
  GoogleFonts.sahitya().fontFamily!,
  GoogleFonts.shadowsIntoLight().fontFamily!,
  GoogleFonts.sonsieOne().fontFamily!,
  GoogleFonts.spaceMono().fontFamily!,
  GoogleFonts.varelaRound().fontFamily!,
  GoogleFonts.wallpoet().fontFamily!,
  GoogleFonts.yanoneKaffeesatz().fontFamily!,
  GoogleFonts.yeonSung().fontFamily!,
  GoogleFonts.zeyada().fontFamily!,
];
