import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor/providers/selected_doctor.dart';
import 'package:provider/provider.dart';

class ProceduresView extends StatelessWidget {
  const ProceduresView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Consumer<PxSelectedDoctor>(
        builder: (context, d, c) {
          return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 6,
                ),
                itemBuilder: (context, index) {
                  final procedure = d.doctor!.procedures[index];
                  return Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        isThreeLine: true,
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Row(
                          children: [
                            Text(procedure.nameEn),
                            const SizedBox(width: 50),
                            if (procedure.isAvailable)
                              const Icon(Icons.check, color: Colors.green)
                            else
                              const Icon(Icons.close, color: Colors.red)
                          ],
                        ),
                        subtitle: Text(
                            "${procedure.nameAr}\n${procedure.price} L.E."),
                        trailing: PopupMenuButton(
                          elevation: 6,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                mouseCursor: SystemMouseCursors.click,
                                onTap: () async {
                                  await EasyLoading.show(status: "Loading...");
                                  final updated = procedure.copyWith(
                                    isAvailable: !procedure.isAvailable,
                                  );
                                  final procedures = d.doctor!.procedures;

                                  procedures[index] = updated;

                                  await d.updateSelectedDoctor(
                                    id: d.doctor!.id,
                                    attribute: 'procedures',
                                    value: procedures
                                        .map((e) => e.toJson())
                                        .toList(),
                                  );
                                  await EasyLoading.dismiss();
                                },
                                child: Row(
                                  children: [
                                    Text(procedure.isAvailable
                                        ? 'Disable'
                                        : "Enable"),
                                    const Spacer(),
                                    Icon(procedure.isAvailable
                                        ? Icons.check_box
                                        : Icons.check_box_outlined),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                mouseCursor: SystemMouseCursors.click,
                                onTap: () async {
                                  await EasyLoading.show(status: "Loading...");
                                  await d.updateSelectedDoctor(
                                    updateType: UpdateType.removeFromList,
                                    id: d.doctor!.id,
                                    attribute: 'procedures',
                                    value: procedure.toJson(),
                                  );
                                  await EasyLoading.dismiss();
                                },
                                child: const Row(
                                  children: [
                                    Text("Delete"),
                                    Spacer(),
                                    Icon(Icons.delete_forever),
                                  ],
                                ),
                              ),
                            ];
                          },
                        ),
                      ),
                    ),
                  );
                },
                itemCount: d.doctor!.procedures.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
