import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:provider/provider.dart';

class DrugsView extends StatelessWidget {
  const DrugsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Consumer<PxSelectedDoctor>(
        builder: (context, d, c) {
          return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 6,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(d.doctor!.drugs[index]),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await EasyLoading.show(status: "Loading...");
                            await d.updateSelectedDoctor(
                              id: d.doctor!.id,
                              attribute: 'drugs',
                              value: [
                                ...d.doctor!.drugs
                                  ..removeWhere(
                                      (drug) => drug == d.doctor!.drugs[index])
                              ],
                            );
                            await EasyLoading.dismiss();
                          },
                        ),
                      ),
                    ),
                  );
                },
                itemCount: d.doctor!.drugs.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
