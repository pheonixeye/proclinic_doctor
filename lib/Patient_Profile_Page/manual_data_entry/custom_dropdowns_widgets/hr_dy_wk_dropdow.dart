import 'package:flutter/material.dart';

List<String> hrdywklist = ['ساعة', 'يوم', 'أسبوع', 'شهر', 'سنة'];
String? freq_hrwkdy;
String? dur_hrwkdy;

class HourDayWeekDropdown extends StatefulWidget {
  final String type;
  const HourDayWeekDropdown({super.key, required this.type});
  @override
  _HourDayWeekDropdownState createState() => _HourDayWeekDropdownState();
}

class _HourDayWeekDropdownState extends State<HourDayWeekDropdown> {
  String? selectedvalue;
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
        child: DropdownButton<String>(
          isExpanded: true,
          underline: Container(
            height: 2,
            color: Colors.blue,
          ),
          icon: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.blue,
          ),
          items: hrdywklist.map((e) {
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
              if (widget.type == 'freq') {
                freq_hrwkdy = value;
              } else if (widget.type == 'dur') {
                dur_hrwkdy = value;
              }
            });
          },
        ),
      ),
    );
  }
}
