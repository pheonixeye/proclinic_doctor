import 'package:proclinic_doctor_windows/Loading_screen/loading_screen.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class NoDBConnectionPage extends StatefulWidget {
  final String? error;

  const NoDBConnectionPage({Key? key, this.error}) : super(key: key);
  @override
  _NoDBConnectionPageState createState() => _NoDBConnectionPageState();
}

class _NoDBConnectionPageState extends State<NoDBConnectionPage> {
  NetworkSettings netset = NetworkSettings();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Failed to innitialize ProClinic App.'),
            const SizedBox(
              height: 20,
            ),
            Card(
                color: Colors.red,
                child: Text('Error : ${widget.error.toString()}')),
            const SizedBox(
              height: 20,
            ),
            const Text('Please Resolve this Error and try again later.'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoadingScreen()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.network_check_outlined),
              label: const Text('Reset Network Configuration'),
              onPressed: () async {
                await netset.resetnetwork();
                await Future.delayed(const Duration(milliseconds: 50));
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoadingScreen()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.close),
              label: const Text('Exit'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
