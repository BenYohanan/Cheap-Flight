import 'dart:convert';

import 'package:cheap_flight/models/flight.dart';
import 'package:cheap_flight/screens/search_flight/search_flight.dart';
import 'package:cheap_flight/size_config.dart';
import 'package:flutter/material.dart';
import 'package:cheap_flight/components/flightTickets.dart';
import 'package:cheap_flight/components/flying_details.dart';
import 'package:cheap_flight/components/flightHeader.dart';
import 'package:cheap_flight/utilities/themeColors.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  static String routeName = "/home";
}

class _HomeScreenState extends State<HomeScreen> {
  List<Flight> flights = [];
  Search search = Search();
  late Future<void> _fetchFlightsFuture;

  @override
  void initState() {
    super.initState();
    _fetchFlightsFuture = fetchFlights();
  }

  Future<void> fetchFlights() async {
    var preferences = await SharedPreferences.getInstance();
    String? flightsJson = preferences.getString('flights');
    String? searchDetails = preferences.getString('search_Details');

    if (flightsJson != null && searchDetails != null) {
      List<dynamic> flightsList = json.decode(flightsJson);
      dynamic searchData = json.decode(searchDetails);

      flights = flightsList.map((e) => Flight.fromJson(e)).toList();
      search = Search.fromJson(searchData);
      setState(() {
        flights = flights;
        search = search;
      });
    } else {
      setState(() {
        flights = [];
        search = Search();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Entypo.chevron_thin_left),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(FontAwesome.search),
            onPressed: () {
              Navigator.popAndPushNamed(context, SearchScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder<void>(
        future: _fetchFlightsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Stack(
              children: <Widget>[
                Container(
                  height: 490.0,
                  decoration: BoxDecoration(
                    color: ThemeColors.green,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(45.0),
                      bottomRight: Radius.circular(45.0),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: getProportionateScreenHeight(10)),
                    FlyingDetails(search: search),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    MyTabs(),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    FlightTickets(flights: flights, search: search)
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
