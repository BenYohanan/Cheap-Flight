import 'package:cheap_flight/size_config.dart';
import 'package:flutter/material.dart';
import 'package:cheap_flight/utilities/themeStyles.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:intl/intl.dart';

import '../models/flight.dart';

class FlyingDetails extends StatefulWidget {
  const FlyingDetails({
    Key? key,
    required this.search,
  }) : super(key: key);
  final Search search;
  @override
  _FlyingDetailsState createState() => _FlyingDetailsState();
}

class _FlyingDetailsState extends State<FlyingDetails> {
  @override
  Widget build(BuildContext context) {
    var returnDate = widget.search.returnDate == null
        ? widget.search.departureDate!
        : widget.search.returnDate!;
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.search.flyingFrom!,
                style: ThemeStyles.departureTextStyle,
              ),
              Text(
                DateFormat().add_MMMEd().format(widget.search.departureDate!),
                style: TextStyle(
                  color: const Color.fromARGB(255, 208, 202, 202),
                  fontSize: getProportionateScreenHeight(20),
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: getProportionateScreenHeight(20)),
                child: const Column(
                  children: [
                    Icon(Entypo.aircraft_take_off,
                        size: 24.0, color: Colors.grey),
                    Icon(Entypo.aircraft_landing,
                        size: 24.0, color: Colors.grey),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: getProportionateScreenHeight(20)),
                child: const Column(
                  children: [
                    Icon(Entypo.aircraft_take_off,
                        size: 24.0, color: Colors.grey),
                    Icon(Entypo.aircraft_landing,
                        size: 24.0, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.search.flyingTo!,
                style: ThemeStyles.arrivalTextStyle,
              ),
              Text(
                DateFormat().add_MMMEd().format(returnDate),
                style: TextStyle(
                  color: Color.fromARGB(255, 234, 228, 228),
                  fontSize: getProportionateScreenHeight(20),
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Row(
            children: <Widget>[
              const Icon(
                Entypo.ticket,
                size: 24.0,
                color: Colors.grey,
              ),
              SizedBox(width: getProportionateScreenWidth(5)),
              Text(
                widget.search.tripType! == "ONE_WAY" ? "ONE WAY" : "ROUND TRIP",
                style: TextStyle(
                  color: Color.fromARGB(255, 217, 243, 242),
                  fontSize: getProportionateScreenHeight(16),
                  fontWeight: FontWeight.w900,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
