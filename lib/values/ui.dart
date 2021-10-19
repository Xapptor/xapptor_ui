import 'package:flutter/material.dart';
import 'package:xapptor_logic/is_portrait.dart';

// General UI data.

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
  "Birthday",
  "Register",
];

List<String> register_values_spanish = [
  "Email",
  "Confirmar email",
  "Contraseña",
  "Confirmar contraseña",
  "Nombres",
  "Apellidos",
  "Fecha de nacimiento",
  "Registrar",
];

List<String> account_values_english =
    register_values_english.sublist(0, register_values_english.length - 1) +
        ["Update"];

List<String> account_values_spanish =
    register_values_spanish.sublist(0, register_values_spanish.length - 1) +
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
