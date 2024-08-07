import 'package:cheap_flight/models/flight.dart';
import 'package:cheap_flight/size_config.dart';
import 'package:flutter/material.dart';
import 'package:cheap_flight/widgets/ticketCard.dart';
import 'package:url_launcher/url_launcher.dart';

class FlightTickets extends StatefulWidget {
  const FlightTickets({
    Key? key,
    required this.flights,
    required this.search,
  }) : super(key: key);
  final List<Flight?> flights;
  final Search search;
  @override
  _FlightTicketsState createState() => _FlightTicketsState();
}

class _FlightTicketsState extends State<FlightTickets> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.flights.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: widget.flights.isEmpty
              ? Align(
                  alignment: Alignment.center,
                  child: Text(
                    "None",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(16),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () async {
                    String url = widget.flights[index]!.url!;
                    final Uri bookingLink = Uri.parse(
                      url,
                    );
                    await launchUrl(
                      bookingLink,
                    );
                  },
                  child: TicketCard(
                    price: widget.flights[index]?.oneWayTripPrice ?? "",
                    originCode: widget.search.flyingFrom ?? "",
                    destinationCode: widget.search.flyingTo ?? "",
                    departureTime:
                        widget.flights[index]!.oneWayDepartureTime ?? "",
                    arrivalTime: widget.flights[index]!.oneWayArrivalTime ?? "",
                    totalTime:
                        widget.flights[index]!.oneWayFlightDuration ?? "",
                    company: widget.flights[index]?.company ?? "",
                    departureDate: widget.search.departureDate,
                    arrivalDate:
                        widget.search.returnDate ?? widget.search.departureDate,
                  ),
                ),
        ),
      ),
    );
  }
}
