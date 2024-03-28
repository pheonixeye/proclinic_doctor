import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/supplies_provider.dart';
import 'package:provider/provider.dart';

class SuppliesPage extends StatefulWidget {
  const SuppliesPage({super.key});

  @override
  State<SuppliesPage> createState() => _SuppliesPageState();
}

class _SuppliesPageState extends State<SuppliesPage> with AfterLayoutMixin {
  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    final docid = context.read<PxSelectedDoctor>().doctor!.id;
    await context.read<PxSupplies>().fetchAllDoctorSupplies(docid);
    if (context.mounted) {
      context.read<PxSupplies>().filterSupplies('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // doctor supplies list
            Expanded(
              flex: 1,
              child: Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<PxSupplies>(
                    builder: (context, s, _) {
                      return Column(
                        children: [
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
                                          "Available: ${item.amount} Units\nPrice: ${item.price} L.E."),
                                      trailing: FloatingActionButton.small(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        backgroundColor: Theme.of(context)
                                            .cardTheme
                                            .shadowColor
                                            ?.withOpacity(0.7),
                                        heroTag: item.id,
                                        child: const Icon(Icons.add),
                                        onPressed: () async {
                                          //TODO: add to visit supplies list
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
            ),
            // supplies list view + remove or alter item
            Expanded(
              flex: 2,
              child: Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
