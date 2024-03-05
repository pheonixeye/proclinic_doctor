import 'package:flutter/material.dart';

class LabRadDropdown extends StatefulWidget {
  int labrad;
  final Function(int) callback;

  LabRadDropdown({
    super.key,
    required this.callback,
    required this.labrad,
  });

  @override
  _LabRadDropdownState createState() => _LabRadDropdownState();
}

//0 == lab, 1 == rad
class _LabRadDropdownState extends State<LabRadDropdown> {
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
          underline: Container(
            height: 2,
            color: Colors.blue,
          ),
          icon: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.blue,
          ),
          isExpanded: true,
          hint: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Select Labs or Rads...')],
          ),
          items: const [
            DropdownMenuItem(
              value: 0,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.library_books),
                SizedBox(
                  width: 20,
                ),
                Text('Labs')
              ]),
            ),
            DropdownMenuItem(
              value: 1,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.camera_roll),
                SizedBox(
                  width: 20,
                ),
                Text('Rads')
              ]),
            ),
          ],
          value: selectedvalue,
          onChanged: (value) {
            // setState(() {});
            selectedvalue = value;
            widget.labrad = value!;
            // setState(() {});
            widget.callback(value);
          },
        ),
      ),
    );
  }
}
