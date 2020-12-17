import 'package:flutter/material.dart';

class CountryDropdown extends StatelessWidget {
  final List<String> countries;
  final String country;
  final Function(String) onChanged;

  const CountryDropdown({
    @required this.countries,
    @required this.country,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          elevation: 6,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).primaryColor,
          ),
          isExpanded: false,
          isDense: true,
          value: country,
          items: countries
              .map(
                (e) => DropdownMenuItem(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12.0,
                        child: Image.asset(
                            'assets/icons/${e.toLowerCase()}_flag.png'),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        e,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  value: e,
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
