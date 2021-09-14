import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:xapptor_ui/webview/webview.dart';
import 'package:xapptor_ui/widgets/crop_widget.dart';
import 'custom_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xapptor_logic/is_portrait.dart';

// General

double sized_box_space = 14;
double outline_border_radius = 20;
double outline_width = 3;
double outline_padding = 15;
double logo_height(BuildContext context) {
  bool portrait = is_portrait(context);
  return MediaQuery.of(context).size.width * (portrait ? 0.3 : 0.1);
}

double logo_width(BuildContext context) {
  bool portrait = is_portrait(context);
  return MediaQuery.of(context).size.width * (portrait ? 0.6 : 0.2);
}

List<String> login_values_english = [
  "Email",
  "Password",
  "Remember me",
  "Log In",
  "Recover password",
  "Register",
];

List<String> login_values_spanish = [
  "Email",
  "Contraseña",
  "Recuerdame",
  "Ingresar",
  "Recuperar contraseña",
  "Registrar",
];

List<String> register_values_english = [
  "Email",
  "Confirm Email",
  "Password",
  "Confirm password",
  "First name",
  "Last name",
  "Enter your date of birth",
  "Register",
];

List<String> register_values_spanish = [
  "Email",
  "Confirmar email",
  "Contraseña",
  "Confirmar contraseña",
  "Nombres",
  "Apellidos",
  "Ingresa la fecha de tu nacimiento",
  "Registrar",
];

List<String> account_values_english =
    register_values_english.sublist(0, register_values_english.length - 2) +
        ["Update"];

List<String> account_values_spanish =
    register_values_spanish.sublist(0, register_values_spanish.length - 2) +
        ["Actualizar"];

List<String> forgot_password_values_english = [
  "Enter your email",
  "Email",
  "Restore your password",
];

List<String> forgot_password_values_spanish = [
  "Ingresa tu email",
  "Email",
  "Restablecer contraseña",
];

List<String> gender_values_english = [
  'Masculine',
  'Femenine',
  'Non-binary',
  'Rather not say',
];

List<String> gender_values_spanish = [
  'Masculino',
  'Femenino',
  'No binario',
  'Prefiero no decir',
];

// Abeinstitute

String logo_image_path_abeinstitute = "assets/images/logo.png";
bool has_language_picker_abeinstitute = true;

RichText tc_and_pp_text_abeinstitute = RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'I accept the ',
        style: TextStyle(color: color_abeinstitute_text),
      ),
      TextSpan(
        text: 'privacy policies.',
        style: TextStyle(
          color: color_abeinstitute_text,
          fontWeight: FontWeight.bold,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            launch("https://www.abeinstitute.com/#/privacy_policy");
          },
      ),
    ],
  ),
);

// Abeinstitute Insurance

String logo_image_path_abeinstitute_insurance = "assets/images/logo.png";
bool has_language_picker_abeinstitute_insurance = true;

custom_background_abeinstitute_insurance(BuildContext context) {
  return Container(
    color: Colors.white,
    width: MediaQuery.of(context).size.width,
    child: Align(
      alignment: Alignment.bottomLeft,
      child: CropWidget(
        child: Image.asset(
          "assets/images/logo.png",
          color: color_abeinstitute_ocean_blue.withOpacity(0.40),
          fit: BoxFit.cover,
        ),
        general_alignment: Alignment.bottomLeft,
        vertical_alignment: Alignment.topCenter,
        horizontal_alignment: Alignment.centerRight,
        height_factor: 0.8,
        width_factor: 0.75,
      ),
    ),
  );
}

// Lum

// String logo_image_path_lum =
//     "https://firebasestorage.googleapis.com/v0/b/lumapp-d8eb7.appspot.com/o/images%2Flogos%2FLOGOTIPO.svg?alt=media&token=2789476c-744f-4a5c-9ebd-3a762d7e80e2";
String logo_image_path_lum = "assets/images/logo.png";

String logo_gotas_path_lum =
    "https://firebasestorage.googleapis.com/v0/b/lumapp-d8eb7.appspot.com/o/images%2Flogos%2FGOTAS%20AV.svg?alt=media&token=01f2e344-5dfb-48d8-9deb-e0c1718d3a5b";
bool has_language_picker_lum = false;

custom_background_lum() {
  return Stack(
    children: [
      Column(
        children: [
          Spacer(flex: 1),
          Expanded(
            flex: 1,
            child: Webview(
              src: logo_gotas_path_lum,
              function: () {},
              id: Uuid().v4(),
            ),
          ),
        ],
      ),
      Container(
        color: Colors.white.withOpacity(0.9),
      ),
    ],
  );
}

// RichText t_and_c_and_pp_text_lum = RichText(
//   text: TextSpan(
//     children: [
//       TextSpan(
//         text: 'Acepto los ',
//         style: TextStyle(color: color_lum_text),
//       ),
//       TextSpan(
//         text: 'términos y condiciones de uso',
//         style: TextStyle(
//           color: color_lum_text,
//           fontWeight: FontWeight.bold,
//         ),
//         recognizer: TapGestureRecognizer()
//           ..onTap = () {
//             launch("https://app.franquiciaslum.com/#/privacy_policy");
//           },
//       ),
//       TextSpan(
//         text: ' y las ',
//         style: TextStyle(color: color_lum_text),
//       ),
//       TextSpan(
//         text: 'políticas de privacidad.',
//         style: TextStyle(
//           color: color_lum_text,
//           fontWeight: FontWeight.bold,
//         ),
//         recognizer: TapGestureRecognizer()
//           ..onTap = () {
//             launch("https://app.franquiciaslum.com/#/privacy_policy");
//           },
//       ),
//     ],
//   ),
// );

RichText tc_and_pp_text_lum = RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Acepto las ',
        style: TextStyle(color: color_lum_text),
      ),
      TextSpan(
        text: 'políticas de privacidad.',
        style: TextStyle(
          color: color_lum_text,
          fontWeight: FontWeight.bold,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            launch("https://app.franquiciaslum.com/#/privacy_policy");
          },
      ),
    ],
  ),
);
