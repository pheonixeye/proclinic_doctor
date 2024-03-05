import 'package:flutter/material.dart';

List<int> units = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31
];
String? notablets;
String? frequencytablet;
String? durationtablet;

class CounterNumbersDropdown extends StatefulWidget {
  final String type;

  const CounterNumbersDropdown({Key? key, required this.type})
      : super(key: key);
  @override
  _CounterNumbersDropdownState createState() => _CounterNumbersDropdownState();
}

class _CounterNumbersDropdownState extends State<CounterNumbersDropdown> {
  int? selectedvalue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(4.0, 4.0),
              blurRadius: 4.0,
            ),
          ],
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton<int>(
          isExpanded: true,
          underline: Container(
            height: 2,
            color: Colors.blue,
          ),
          icon: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.blue,
          ),
          items: units.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(e.toString())],
              ),
            );
          }).toList(),
          value: selectedvalue,
          onChanged: (value) {
            setState(() {
              selectedvalue = value;
              if (widget.type == 'units') {
                notablets = value.toString();
              } else if (widget.type == 'freq') {
                frequencytablet = value.toString();
              } else if (widget.type == 'dur') {
                durationtablet = value.toString();
              }
            });
          },
        ),
      ),
    );
  }
}
