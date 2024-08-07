import 'package:cheap_flight/size_config.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:cheap_flight/utilities/themeColors.dart';
import 'package:cheap_flight/utilities/themeStyles.dart';

class TicketCard extends StatefulWidget {
  final String? price;
  final String? destinationCode;
  final String? originCode;
  final String? arrivalTime;
  final String? departureTime;
  final bool? stops;
  final String? totalTime;
  final String? company;
  final DateTime? departureDate;
  final DateTime? arrivalDate;
  TicketCard(
      {this.price,
      this.arrivalTime,
      this.departureTime,
      this.destinationCode,
      this.originCode,
      this.stops,
      this.totalTime,
      this.company,
      this.departureDate,
      this.arrivalDate});
  @override
  _TicketCardState createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 1),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 30.0, left: 35.0, right: 35.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '${widget.price}',
                            style: TextStyle(
                              color: const Color(0xFFff7259),
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(15)),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Text(
                      //         DateFormat()
                      //             .add_MMMEd()
                      //             .format(widget.departureDate!),
                      //         style: ThemeStyles.greyStyle),
                      //     Text(
                      //         DateFormat()
                      //             .add_MMMEd()
                      //             .format(widget.arrivalDate!),
                      //         style: ThemeStyles.greyStyle),
                      //   ],
                      // ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('${widget.originCode}',
                              style: ThemeStyles.mainBlackTextStyle),
                          Text('${widget.destinationCode}',
                              style: ThemeStyles.mainBlackTextStyle)
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('${widget.departureTime}',
                              style: ThemeStyles.subBlackTextStyle),
                          Text('${widget.arrivalTime}',
                              style: ThemeStyles.subBlackTextStyle),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.blur_on, color: Colors.grey),
                          const Text('- - - - - - - - - - - - '),
                          Icon(
                            Entypo.aircraft_take_off,
                            color: Colors.grey,
                            size: getProportionateScreenHeight(25),
                          ),
                          const Text('- - - - - - - - - - - - '),
                          const Icon(Icons.blur_on, color: Colors.grey),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.totalTime!.isEmpty
                                ? "No available flight"
                                : '${widget.totalTime} mins',
                            style: ThemeStyles.greyStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.orange,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0)),
                  ),
                  height: getProportionateScreenHeight(60),
                  width: getProportionateScreenWidth(100),
                  child: Center(
                    child: Text(
                      widget.company!,
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(15),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
