import 'package:cheap_flight/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_app_bar.dart';
import 'components/body.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = "/search";

  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          AppBar().preferredSize.height,
        ),
        child: CustomAppBar(
          routeName: SplashScreen.routeName,
        ),
      ),
      body: const Body(),
    );
  }
}
