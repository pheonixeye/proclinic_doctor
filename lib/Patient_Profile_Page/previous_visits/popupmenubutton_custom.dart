import 'package:flutter/material.dart';

class CustomPOPUPBUTTON extends StatefulWidget {
  final VoidCallback callPresc;
  final VoidCallback callDocs;

  const CustomPOPUPBUTTON({
    super.key,
    required this.callPresc,
    required this.callDocs,
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
      icon: const CircleAvatar(
        child: Icon(
          Icons.menu_open,
        ),
      ),
      tooltip: 'Options',
      itemBuilder: (context) {
        return <PopupMenuItem<String>>[
          PopupMenuItem(
            onTap: widget.callPresc,
            value: 'presc',
            child: const Row(
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
          PopupMenuItem(
            onTap: widget.callDocs,
            value: 'docs',
            child: const Row(
              children: [
                Icon(
                  Icons.document_scanner,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Documents'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
