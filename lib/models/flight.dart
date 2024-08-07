import 'package:intl/intl.dart';

class Flight {
  String? url;
  String? oneWayTripImage;
  String? returnTripImage;
  String? company;
  String? oneWayTripPrice;
  String? returnTripPrice;
  String? oneWayFlightDuration;
  String? returnTripFlightDuration;
  String? returnTripArrivalTime;
  String? returnTripDepartureTime;
  String? oneWayDepartureTime;
  String? oneWayArrivalTime;

  Flight({
    this.url,
    this.oneWayTripImage,
    this.returnTripImage,
    this.company,
    this.oneWayTripPrice,
    this.returnTripPrice,
    this.oneWayFlightDuration,
    this.returnTripFlightDuration,
    this.returnTripArrivalTime,
    this.returnTripDepartureTime,
    this.oneWayDepartureTime,
    this.oneWayArrivalTime,
  });

  Flight.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    oneWayTripImage = json['oneWayTripImage'];
    returnTripImage = json['returnTripImage'];
    company = json['company'];
    oneWayTripPrice = json['oneWayTripPrice'];
    returnTripPrice = json['returnTripPrice'];
    oneWayFlightDuration = json['oneWayFlightDuration'];
    returnTripFlightDuration = json['returnTripFlightDuration'];
    returnTripArrivalTime = json['returnTripArrivalTime'];
    returnTripDepartureTime = json['returnTripDepartureTime'];
    oneWayDepartureTime = json['oneWayDepartureTime'];
    oneWayArrivalTime = json['oneWayArrivalTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Url'] = url;
    data['OneWayTripImage'] = oneWayTripImage;
    data['ReturnTripImage'] = returnTripImage;
    data['Company'] = company;
    data['OneWayTripPrice'] = oneWayTripPrice;
    data['ReturnTripPrice'] = returnTripPrice;
    data['OneWayFlightDuration'] = oneWayFlightDuration;
    data['ReturnTripFlightDuration'] = returnTripFlightDuration;
    return data;
  }
}

class Search {
  int? adults;
  int? children;
  int? infants;
  String? tripType;
  String? flyingFrom;
  String? flyingTo;
  DateTime? departureDate;
  DateTime? returnDate;

  Search(
      {this.adults,
      this.children,
      this.infants,
      this.tripType,
      this.flyingFrom,
      this.flyingTo,
      this.departureDate,
      this.returnDate});

  Search.fromJson(Map<String, dynamic> json) {
    DateFormat format = DateFormat('dd-MM-yyyy');
    adults = json['Adult'];
    children = json['Children'];
    infants = json['Infants'];
    tripType = json['TripType'];
    flyingFrom = json['FlyingFrom'];
    flyingTo = json['FlyingTo'];
    var departureDateInString = json['DepartureDate'];
    if (departureDateInString != null) {
      departureDate = format.parse(departureDateInString);
    }
    var returnDateInString = json['ReturnDate'];
    if (returnDateInString != null) {
      departureDate = format.parse(returnDateInString);
    }
  }
}
