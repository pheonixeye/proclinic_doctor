import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:printing/printing.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:proclinic_doctor_windows/providers/prescription_settings_provider.dart';
import 'package:proclinic_doctor_windows/widgets/central_loading.dart';
import 'package:proclinic_models/proclinic_models.dart';
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
                    flex: 2,
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
                                if (value != null) {
                                  await EasyLoading.show(status: "Loading...");
                                  await s.updatePrescriptionSettings(
                                      key: 'usePrinted', value: value);
                                  await EasyLoading.showSuccess('Success...');
                                }
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
                              subtitle: Text(
                                s.settings?.path ?? 'Path Not Selected.',
                              ),
                              trailing: FloatingActionButton.small(
                                heroTag: 'select-presc-path',
                                child: const Icon(Icons.upload_file),
                                onPressed: () async {
                                  //todo: pick file
                                  //todo: store file path
                                  final result =
                                      await FilePicker.platform.pickFiles(
                                    dialogTitle:
                                        "Select Pdf Prescription File Path.",
                                    type: FileType.custom,
                                    allowMultiple: false,
                                    allowedExtensions: ['pdf'],
                                    withData: false,
                                  );
                                  if (result != null) {
                                    final path = result.paths.first;

                                    await EasyLoading.show(
                                        status: "Loading...");
                                    await s.updatePrescriptionSettings(
                                        key: 'path', value: path);
                                    await EasyLoading.showSuccess('Success...');
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        if (s.settings != null && s.settings!.path != null)
                          ...PosDataType.values.map((e) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 6,
                                child: RadioListTile<PosDataType>.adaptive(
                                  title: Text(e.forWidgets()),
                                  value: e,
                                  groupValue: s.posDataType,
                                  onChanged: (value) {
                                    s.selectPosDataType(value);
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                      ],
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Card(
                            child: PdfPreview(
                              pageFormats: s.pageFormats,
                              maxPageWidth: 600,
                              dpi: 72,
                              build: (_) {
                                return s.pdfPrescriptionBuilder;
                              },
                            ),
                          ),
                          Positioned(
                            left: s.settings?.data[s.posDataType.toString()]?.x,
                            top: s.settings?.data[s.posDataType.toString()]?.y,
                            child: Builder(
                              builder: (context) {
                                final PositionedDataItem? data =
                                    s.settings?.data[s.posDataType.toString()];
                                return Draggable(
                                  feedback: Text(
                                    "{{ ${s.posDataType?.forWidgets() ?? ''} }}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Text(
                                    "{{ ${s.posDataType?.forWidgets() ?? ''} }}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onDragEnd: (details) async {
                                    if (data != null) {
                                      final newData = data.copyWith(
                                        x: details.offset.dx,
                                        y: details.offset.dy,
                                      );
                                      await EasyLoading.show(
                                          status: 'Loading...');
                                      await s.updatePrescriptionData(
                                          newData: newData);
                                      await EasyLoading.showSuccess(
                                          'Success...');
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
