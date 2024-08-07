import 'package:cheap_flight/utilities/themeColors.dart';
import 'package:flutter/material.dart';
import 'package:cheap_flight/services/app_state.dart';
import 'package:provider/provider.dart';

class MyTabs extends StatefulWidget {
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 30.0),
        child: Consumer<AppState>(
          builder: (context, appState, _) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 45.0,
              width: MediaQuery.of(context).size.width - 82,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
              child: Container(
                width: 110,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Center(
                  child: Text(
                    "FLIGHTS",
                    style: TextStyle(
                      color: ThemeColors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
