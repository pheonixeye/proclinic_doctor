import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:provider/provider.dart';

class AddNewDrugLabRadButton extends StatelessWidget {
  const AddNewDrugLabRadButton({
    super.key,
    required this.value,
    required this.drugLabOrRad,
  });
  final String value;
  final String drugLabOrRad;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<PxSelectedDoctor>(
        builder: (context, d, _) {
          return FloatingActionButton(
            heroTag: 'AddNew$drugLabOrRad',
            onPressed: () async {
              await EasyLoading.show(status: "Loading...");
              final List<String> _data = switch (drugLabOrRad) {
                'drugs' => d.doctor!.drugs,
                'labs' => d.doctor!.labs,
                'rads' => d.doctor!.rads,
                _ => throw UnimplementedError(),
              };
              await d.updateSelectedDoctor(
                docname: d.doctor!.docnameEN,
                attribute: drugLabOrRad,
                value: [..._data, value],
              );
              await EasyLoading.showSuccess('$drugLabOrRad Updated...');
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
