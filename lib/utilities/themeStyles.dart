import 'package:cheap_flight/size_config.dart';
import 'package:flutter/material.dart';
import './themeColors.dart';

class ThemeStyles {
  static TextStyle departureTextStyle = TextStyle(
    color: Colors.white,
    fontSize: getProportionateScreenHeight(35),
  );
  static TextStyle arrivalTextStyle = TextStyle(
    color: Colors.white,
    fontSize: getProportionateScreenHeight(35),
    fontWeight: FontWeight.w700,
  );
  static TextStyle travelDateTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 25.0,
    fontWeight: FontWeight.w100,
  );
  static TextStyle dropDownTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 15.0,
  );
  static TextStyle ticketPrice = TextStyle(
    color: ThemeColors.orange,
    fontSize: getProportionateScreenHeight(16),
    fontWeight: FontWeight.w900,
  );
  static TextStyle greyStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 15.0,
  );
  static TextStyle mainBlackTextStyle = TextStyle(
    color: const Color.fromARGB(255, 82, 75, 75),
    fontSize: getProportionateScreenHeight(30),
    fontWeight: FontWeight.w400,
  );
  static TextStyle subBlackTextStyle = TextStyle(
    color: const Color.fromARGB(255, 55, 54, 54),
    fontSize: getProportionateScreenHeight(15),
    fontWeight: FontWeight.w500,
  );
}
