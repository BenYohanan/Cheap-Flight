import 'package:cheap_flight/screens/home_screen.dart';
import 'package:cheap_flight/utilities/themeColors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This is the best practice
import '../../../size_config.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/dialogs.dart';
import '../../search_flight/search_flight.dart';
import '../components/splash_content.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

@override
class _BodyState extends State<Body> {
  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "text": "Where do you want to go?",
      "image": "assets/images/airplane.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () async {
                        Dialogs.loader(context);
                        bool hasPreviousSearch = await isSearchPrevious();
                        Dialogs.loader(context);
                        if (hasPreviousSearch) {
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        } else {
                          Navigator.pushNamed(context, SearchScreen.routeName);
                        }
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: ThemeColors.kAnimationDuration,
      margin: const EdgeInsets.only(
        right: 5,
      ),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? ThemeColors.greenLight
            : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

Future<bool> isSearchPrevious() async {
  var preferences = await SharedPreferences.getInstance();
  String? flightsJson = preferences.getString('flights');
  String? searchDetails = preferences.getString('search_Details');
  return flightsJson != null && searchDetails != null;
}
