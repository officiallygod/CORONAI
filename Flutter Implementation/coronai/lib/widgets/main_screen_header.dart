import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'country_dropdown.dart';

class MainScreenHeader extends StatefulWidget {
  @override
  _MainScreenHeaderState createState() => _MainScreenHeaderState();
}

class _MainScreenHeaderState extends State<MainScreenHeader> {
  String _country = 'IN';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        Container(
          height: mediaQuery.size.height * 0.37,
          width: mediaQuery.size.width,
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45.0),
              bottomRight: Radius.circular(45.0),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Warrior',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      letterSpacing: 1.8,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CountryDropdown(
                    countries: ['CN', 'FR', 'IN', 'IT', 'UK', 'US'],
                    country: _country,
                    onChanged: (val) => setState(() => _country = val),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 20.0,
                bottom: 30.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you feeling sick?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontFamily: 'Caveat',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.size.height * 0.01,
                  ),
                  Text(
                    'If you are sick with any COVID-19 symptoms, please call or text us immediately for help',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18.0,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton.icon(
                  onPressed: () => launch("tel:+91-11-23978046"),
                  color: Colors.redAccent,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  splashColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  icon: const Icon(
                    CupertinoIcons.phone,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Call Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                FlatButton.icon(
                  onPressed: () => launch("sms:1075"),
                  color: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  splashColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  icon: const Icon(
                    CupertinoIcons.conversation_bubble,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Send SMS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
