import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/constants/attribute_language.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:provider/provider.dart';

class DoctorTitlesCard extends StatefulWidget {
  const DoctorTitlesCard({super.key, required this.al});
  final AttributeLanguage al;
  @override
  State<DoctorTitlesCard> createState() => _DoctorTitlesCardState();
}

class _DoctorTitlesCardState extends State<DoctorTitlesCard> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PxSelectedDoctor>(
      builder: (context, d, _) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(),
              const Spacer(),
              Text(switch (widget.al) {
                AttributeLanguage.en => 'English Doctor Titles',
                AttributeLanguage.ar => 'Arabic Doctor Titles',
              }),
              const Spacer(),
              Expanded(
                flex: 2,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: switch (widget.al) {
                          AttributeLanguage.en => 'English Titles',
                          AttributeLanguage.ar => 'Arabic Titles',
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Save'),
                onPressed: () async {
                  await EasyLoading.show(status: "Loading...");
                  //todo: request change
                  switch (widget.al) {
                    case AttributeLanguage.en:
                      await d.updateSelectedDoctor(
                        docname: d.doctor!.docnameEN,
                        attribute: SxDoctor.TITLES_E,
                        value: [...d.doctor!.titlesEN, _controller.text],
                      );
                      break;
                    case AttributeLanguage.ar:
                      await d.updateSelectedDoctor(
                        docname: d.doctor!.docnameEN,
                        attribute: SxDoctor.TITLES_A,
                        value: [...d.doctor!.titlesAR, _controller.text],
                      );
                      break;
                  }

                  _controller.clear();
                  await EasyLoading.showSuccess('Updated.');
                },
              ),
              const Spacer(),
            ],
          ),
          subtitle: ConstrainedBox(
            constraints: const BoxConstraints.tightForFinite(
              height: 300,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: GridView.builder(
                  itemCount: switch (widget.al) {
                    AttributeLanguage.en => d.doctor!.titlesEN.length,
                    AttributeLanguage.ar => d.doctor!.titlesAR.length,
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: GridTileBar(
                          title: SelectableText(
                            switch (widget.al) {
                              AttributeLanguage.en => d.doctor!.titlesEN[index],
                              AttributeLanguage.ar => d.doctor!.titlesAR[index],
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: const CircleAvatar(),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await EasyLoading.show(status: "Loading...");
                              //todo: delete item

                              switch (widget.al) {
                                case AttributeLanguage.en:
                                  await d.updateSelectedDoctor(
                                    docname: d.doctor!.docnameEN,
                                    attribute: SxDoctor.TITLES_E,
                                    value: [...d.doctor!.titlesEN]
                                      ..removeAt(index),
                                  );
                                  break;
                                case AttributeLanguage.ar:
                                  await d.updateSelectedDoctor(
                                    docname: d.doctor!.docnameEN,
                                    attribute: SxDoctor.TITLES_A,
                                    value: [...d.doctor!.titlesAR]
                                      ..removeAt(index),
                                  );
                                  break;
                              }

                              await EasyLoading.showSuccess('Updated.');
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
