import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/providers/form_loader.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class SelectFormDialog extends StatelessWidget {
  const SelectFormDialog({super.key, required this.forms});
  final List<ProClinicForm> forms;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Text("Select Form"),
          const Spacer(),
          FloatingActionButton.small(
            heroTag: 'close-select-form',
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onPressed: () {
              if (context.mounted) {
                context.read<PxFormLoader>().selectForm(null);
                Navigator.pop(context);
              }
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: Container(
        width: 600,
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(),
          boxShadow: const [BoxShadow()],
        ),
        child: ListView.builder(
          itemCount: forms.length,
          itemBuilder: (context, index) {
            final item = forms[index];
            return Tooltip(
              message: item.descriptionEn ?? "",
              child: Card(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text("${index + 1}"),
                    ),
                    title: Text(item.titleEn),
                    onTap: () async {
                      await EasyLoading.show(status: "Loading...");
                      if (context.mounted) {
                        context.read<PxFormLoader>().selectForm(item);
                        await context
                            .read<PxVisitData>()
                            .updateVisitData(SxVD.FORMID, item.id);
                        await EasyLoading.showSuccess("Form Attached...")
                            .then((_) => Navigator.pop(context));
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
