import 'dart:io';

import 'package:flutter/material.dart';

class WrongMacAddrPage extends StatelessWidget {
  const WrongMacAddrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'UnAuthorized Device',
          textScaler: TextScaler.linear(2.0),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Builder(
        builder: (context) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(4.0, 4.0),
                    blurRadius: 4.0,
                  ),
                ],
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                          'This Device is not registered for using the Application.'),
                      const Text(' \n Kindly Contact the vendor.'),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.exit_to_app),
                        label: const Text('Exit'),
                        onPressed: () {
                          exit(0);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
