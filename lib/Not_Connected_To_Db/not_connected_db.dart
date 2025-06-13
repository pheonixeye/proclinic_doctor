import 'package:proclinic_doctor/Loading_screen/loading_screen.dart';
import 'package:proclinic_doctor/network_settings/network_class.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:proclinic_doctor/network_settings/network_settings_ui.dart';

class NoDBConnectionPage extends StatefulWidget {
  final String? error;

  const NoDBConnectionPage({super.key, this.error});
  @override
  State<NoDBConnectionPage> createState() => _NoDBConnectionPageState();
}

class _NoDBConnectionPageState extends State<NoDBConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Failed to innitialize ProClinic App.'),
            const SizedBox(height: 20),
            Card(
              color: Colors.red,
              child: Text('Error : ${widget.error.toString()}'),
            ),
            const SizedBox(height: 20),
            const Text('Please Resolve this Error and try again later.'),
            FutureBuilder<String?>(
              future: NetworkSettings.instance.getIpAddress(),
              builder: (context, snapshot) {
                return Text(
                  'Ip Address : ${snapshot.hasData ? snapshot.data : ""}',
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoadingScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.network_check_outlined),
              label: const Text('Reset Network Configuration'),
              onPressed: () async {
                await NetworkSettings.instance.resetnetwork();
                await Future.delayed(const Duration(milliseconds: 50));
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoadingScreen(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text('Network Settings'),
              onPressed: () async {
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NetworkSettingsPage(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
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
