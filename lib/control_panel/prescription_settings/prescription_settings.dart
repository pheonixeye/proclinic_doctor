import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:proclinic_doctor_windows/providers/prescription_settings_provider.dart';
import 'package:proclinic_doctor_windows/widgets/central_loading.dart';
import 'package:provider/provider.dart';

class PrescriptionSettingsPage extends StatelessWidget {
  const PrescriptionSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSettingsNavDrawer(),
      appBar: AppBar(
        title: const Text(
          'Prescription Settings',
          textScaler: TextScaler.linear(2.0),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PxPrescriptionSettings>(
          builder: (context, s, _) {
            while (s.settings == null) {
              return const CentralLoading();
            }
            return Card.outlined(
              elevation: 6,
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 6,
                            child: CheckboxListTile(
                              secondary: const CircleAvatar(),
                              title:
                                  const Text('Use Printed Pdf Prescription :'),
                              value: s.settings?.usePrinted,
                              onChanged: (value) async {
                                await EasyLoading.show(status: "Loading...");
                                await s.updatePrescriptionSettings();
                                await EasyLoading.showSuccess('Success...');
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 6,
                            child: ListTile(
                              leading: const CircleAvatar(),
                              title: const Text('Select Pdf File Path'),
                              subtitle: const Text('Path Not Selected.'),
                              trailing: FloatingActionButton.small(
                                heroTag: 'select-presc-path',
                                child: const Icon(Icons.upload_file),
                                onPressed: () async {
                                  //TODO: pick file
                                  //TODO: store file path

                                  await EasyLoading.show(status: "Loading...");
                                  await s.updatePrescriptionSettings();
                                  await EasyLoading.showSuccess('Success...');
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: Container(
                        //TODO: put pdf viewer
                        //TODO: implemet updates
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
