import 'package:cheap_flight/utilities/themeColors.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

import '../../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Text(
          "Cheap Flight",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: ThemeColors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Entypo.aircraft_take_off,
          color: Colors.grey,
          size: getProportionateScreenHeight(25),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
