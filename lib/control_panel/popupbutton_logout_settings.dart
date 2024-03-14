import 'package:flutter/material.dart';

class PopUpButtonLogOutSettings extends StatefulWidget {
  final Function callSettings;
  final Function callLogout;

  const PopUpButtonLogOutSettings(
      {super.key, required this.callSettings, required this.callLogout});

  @override
  State<PopUpButtonLogOutSettings> createState() =>
      _PopUpButtonLogOutSettingsState();
}

class _PopUpButtonLogOutSettingsState extends State<PopUpButtonLogOutSettings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(15, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      onSelected: (String value) async {
        setState(() {
          if (value == 'settings') {
            print('settings');
            widget.callSettings();
          } else if (value == 'logout') {
            print('logout');
            widget.callLogout();
          }
        });
      },
      onCanceled: () {
        setState(() {});
      },
      icon: const Icon(
        Icons.menu,
      ),
      tooltip: 'Options',
      itemBuilder: (context) {
        return <PopupMenuItem<String>>[
          const PopupMenuItem(
            value: 'settings',
            child: Row(children: [
              Icon(
                Icons.settings,
                color: Colors.green,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Clinic Settings'),
            ]),
          ),
          const PopupMenuItem(
            value: 'logout',
            child: Row(children: [
              Icon(
                Icons.logout,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Logout'),
            ]),
          ),
        ];
      },
    );
  }
}
