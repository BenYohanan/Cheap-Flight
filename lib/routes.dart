import 'package:cheap_flight/screens/home_screen.dart';
import 'package:flutter/widgets.dart';

import 'screens/search_flight/search_flight.dart';
import 'screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  SearchScreen.routeName: (context) => const SearchScreen(),
};
