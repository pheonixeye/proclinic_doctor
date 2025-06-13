import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor/providers/supplies_provider.dart';
import 'package:proclinic_doctor/providers/visit_data_provider.dart';
import 'package:provider/provider.dart';

class SuppliesStore extends StatelessWidget {
  const SuppliesStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PxSupplies>(
            builder: (context, s, _) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Supplies Store",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Search Items...",
                      ),
                      onChanged: (value) {
                        s.filterSupplies(value);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: s.filteredSupplies.length,
                      itemBuilder: (context, index) {
                        final item = s.filteredSupplies[index];
                        return Card(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              title: Text(item.nameEn),
                              subtitle: Text(
                                "Available: ${item.amount} Units\nPrice: ${item.price} L.E.",
                              ),
                              trailing: FloatingActionButton.small(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                backgroundColor: Theme.of(
                                  context,
                                ).cardTheme.shadowColor?.withOpacity(0.7),
                                heroTag: item.id,
                                child: const Icon(Icons.add),
                                onPressed: () async {
                                  //todo: add to visit supplies list
                                  await EasyLoading.show(status: "Loading...");
                                  if (context.mounted) {
                                    await context
                                        .read<PxVisitData>()
                                        .addSuppliesToVisit(
                                          item.toVisitSupplyItem(),
                                        );
                                  }
                                  await EasyLoading.dismiss();

                                  if (context.mounted) {
                                    await context
                                        .read<PxSupplies>()
                                        .fetchAllDoctorSupplies()
                                        .whenComplete(() {
                                          if (context.mounted) {
                                            context
                                                .read<PxSupplies>()
                                                .filterSupplies('');
                                          }
                                        });
                                  }
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
