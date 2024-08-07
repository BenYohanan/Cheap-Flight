import 'dart:convert';

import 'package:cheap_flight/utilities/themeColors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../size_config.dart';
import '../../../../widgets/dialogs.dart';
import '../../../models/dropDownItem.dart';
import '../../home_screen.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? date;
  final TravelViewModel viewModel = TravelViewModel();
  final TravelSelection selection = TravelSelection();
  DateTime? departureDate;
  DateTime? arrivalDate;
  int _selectedTripType = 0; // 0 for One Way, 1 for Round Trip
  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: ThemeColors.greenLight,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
      helpText: "Flight Date",
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(2020, 1, 1),
      lastDate: DateTime(3030),
    );
    if (picked != null &&
        picked != (isDeparture ? departureDate : arrivalDate)) {
      setState(() {
        if (isDeparture) {
          departureDate = picked;
        } else {
          arrivalDate = picked;
        }
      });
    }
  }

  Future<void> _submitForm() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await preferences.remove('flight_Details');
    await preferences.remove('search_Details');
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    final flightData = {
      'TripType': _selectedTripType == 0 ? 'ONE_WAY' : 'ROUND_TRIP',
      'FlyingFrom': selection.from?.value,
      'FlyingTo': selection.to?.value,
      'DepartureDate': departureDate != null
          ? DateFormat('yyyy-MM-dd').format(departureDate!)
          : null,
      'ReturnDate': arrivalDate != null
          ? DateFormat('yyyy-MM-dd').format(arrivalDate!)
          : null,
      'Adult': selection.adults,
      'Child': selection.children,
      'Infant': selection.infants,
    };
    final searchDetails = {
      'TripType': _selectedTripType == 0 ? 'ONE_WAY' : 'ROUND_TRIP',
      'FlyingFrom': selection.from?.value,
      'FlyingTo': selection.to?.value,
      'DepartureDate': departureDate != null
          ? DateFormat('dd-MM-yyy').format(departureDate!)
          : null,
      'ReturnDate': arrivalDate != null
          ? DateFormat('dd-MM-yyy').format(arrivalDate!)
          : null
    };

    var data = json.encode(flightData);
    var url = Uri.parse("https://cheapflight.ng/GetFlights?flightData=$data");

    try {
      Dialogs.loader(context);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        var decodedResponse = json.decode(response.body);
        var result = decodedResponse['data'];
        await preferences.setString('flights', json.encode(result));
        await preferences.setString(
            'search_Details', json.encode(searchDetails));
        Navigator.pushNamed(
          context,
          HomeScreen.routeName,
        );
      } else {
        Navigator.of(context).pop();
        Dialogs.flushBar(
          context,
          "Failed",
          "Unable to fetch flights",
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      Dialogs.flushBar(
        context,
        "Failed",
        "Enter Correct Domain",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: 0,
                groupValue: _selectedTripType,
                activeColor: ThemeColors.greenLight,
                onChanged: (value) {
                  setState(() {
                    _selectedTripType = value!;
                  });
                },
              ),
              const Text(
                "One Way",
              ),
              Radio(
                value: 1,
                groupValue: _selectedTripType,
                activeColor: ThemeColors.greenLight,
                onChanged: (value) {
                  setState(() {
                    _selectedTripType = value!;
                  });
                },
              ),
              const Text(
                "Round Trip",
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          DropdownSearch<TravelOption>(
            popupProps: const PopupProps.menu(showSearchBox: true),
            items: viewModel.locations,
            itemAsString: (TravelOption option) => option.label,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: "Departure",
                labelText: "Flying From",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ThemeColors.greenLight,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(14),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: GestureDetector(
                  child: const Icon(Icons.flight_takeoff),
                ),
              ),
            ),
            onChanged: (TravelOption? value) {
              setState(() {
                selection.from = value;
              });
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          DropdownSearch<TravelOption>(
            popupProps: const PopupProps.menu(showSearchBox: true),
            items: viewModel.locations,
            itemAsString: (TravelOption option) => option.label,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Flying To",
                hintText: "Destination",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ThemeColors.green,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: GestureDetector(
                  child: const Icon(Icons.flight_land),
                ),
              ),
            ),
            onChanged: (TravelOption? value) {
              setState(() {
                selection.to = value;
              });
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, true),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Departure Date",
                        hintText: "Select",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeColors.greenLight,
                            style: BorderStyle.solid,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: departureDate == null
                            ? ''
                            : DateFormat('yyyy-MM-dd').format(departureDate!),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenHeight(10),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, false),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Arrival Date",
                        hintText: "Select",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeColors.greenLight,
                            style: BorderStyle.solid,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: arrivalDate == null
                            ? ''
                            : DateFormat('yyyy-MM-dd').format(arrivalDate!),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenWidth(20),
          ),
          DropdownSearch<TravelOption>(
            popupProps: const PopupProps.menu(showSearchBox: true),
            items: viewModel.adultOptions,
            itemAsString: (TravelOption option) => option.label,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Adults",
                hintText: "Select Number of Adults",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ThemeColors.greenLight,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: GestureDetector(
                  child: const Icon(Icons.person),
                ),
              ),
            ),
            onChanged: (TravelOption? value) {
              setState(() {
                selection.adults = int.parse(value!.value);
              });
            },
            selectedItem: viewModel.adultOptions[selection.adults - 1],
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          DropdownSearch<TravelOption>(
            popupProps: const PopupProps.menu(showSearchBox: true),
            items: viewModel.childOptions,
            itemAsString: (TravelOption option) => option.label,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Children",
                hintText: "Select Number of Children",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ThemeColors.greenLight,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: GestureDetector(
                  child: const Icon(Icons.child_care),
                ),
              ),
            ),
            onChanged: (TravelOption? value) {
              setState(() {
                selection.children = int.parse(value!.value);
              });
            },
            selectedItem: viewModel.childOptions[selection.children],
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          DropdownSearch<TravelOption>(
            popupProps: const PopupProps.menu(showSearchBox: true),
            items: viewModel.infantOptions,
            itemAsString: (TravelOption option) => option.label,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Infants",
                hintText: "Select Number of Infants",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ThemeColors.greenLight,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: GestureDetector(
                  child: const Icon(Icons.child_friendly),
                ),
              ),
            ),
            onChanged: (TravelOption? value) {
              setState(() {
                selection.infants = int.parse(value!.value);
              });
            },
            selectedItem: viewModel.infantOptions[selection.infants],
          ),
          GestureDetector(
            onTap: _submitForm,
            child: Container(
              height: 60,
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.only(
                top: getProportionateScreenWidth(40),
              ),
              decoration: BoxDecoration(
                color: ThemeColors.greenLight,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Center(
                child: Text(
                  "Search",
                  style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800,
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
