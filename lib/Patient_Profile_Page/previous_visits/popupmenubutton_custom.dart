import 'package:flutter/material.dart';

class CustomPOPUPBUTTON extends StatefulWidget {
  final Function callPrint;
  final Function callPresc;

  const CustomPOPUPBUTTON({
    super.key,
    required this.callPrint,
    required this.callPresc,
  });

  @override
  State<CustomPOPUPBUTTON> createState() => _CustomPOPUPBUTTONState();
}

class _CustomPOPUPBUTTONState extends State<CustomPOPUPBUTTON> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      offset: const Offset(0, 50),
      elevation: 10,
      onSelected: (String value) async {
        setState(() {
          if (value == 'print') {
            widget.callPrint();
          } else if (value == 'presc') {
            widget.callPresc();
          }
        });
      },
      icon: const CircleAvatar(
        child: Icon(
          Icons.menu_open,
        ),
      ),
      tooltip: 'Options',
      itemBuilder: (context) {
        return <PopupMenuItem<String>>[
          const PopupMenuItem(
            value: 'print',
            child: Row(children: [
              Icon(
                Icons.print,
                color: Colors.blue,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Print Sheet'),
            ]),
          ),
          const PopupMenuItem(
            value: 'presc',
            child: Row(
              children: [
                Icon(
                  Icons.library_books,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Prescription'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
