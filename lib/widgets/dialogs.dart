import 'package:another_flushbar/flushbar.dart';
import 'package:cheap_flight/utilities/themeColors.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class Dialogs {
  static Future flushBar(
    BuildContext context,
    String title,
    String message,
  ) {
    return Flushbar(
      margin: const EdgeInsets.all(4),
      backgroundColor: ThemeColors.orange,
      titleText: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: getProportionateScreenWidth(20),
          color: Colors.white,
        ),
      ),
      duration: const Duration(seconds: 2),
      titleColor: Colors.white,
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      flushbarPosition: FlushbarPosition.BOTTOM,
      maxWidth: 260,
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }

  static Widget label(String label) {
    return Center(
      child: Text(
        label,
        style: TextStyle(
          color: ThemeColors.orange,
          fontWeight: FontWeight.w900,
          fontSize: getProportionateScreenWidth(20),
        ),
      ),
    );
  }

  static loader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AnimatedContainer(
          curve: Curves.bounceInOut,
          duration: const Duration(
            seconds: 20,
          ),
          child: SizedBox(
            width: getProportionateScreenWidth(30),
            height: getProportionateScreenHeight(30),
            child: Center(
              child: Image.asset(
                "assets/images/airplane.png",
                width: getProportionateScreenWidth(60),
                height: getProportionateScreenWidth(60),
              ),
            ),
          ),
        );
      },
    );
  }
}
