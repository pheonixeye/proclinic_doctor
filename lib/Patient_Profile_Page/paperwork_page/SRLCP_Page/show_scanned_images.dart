import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:proclinic_doctor_windows/Patient_Profile_Page/paperwork_page/SRLCP_Page/image_stream.dart';
import 'package:flutter/material.dart';

//TODO: next and prev image mekanizm through steps widget
//TODO: refactor image show mechanizm

class ScannedImagesWidget extends StatefulWidget {
  final String dbNamebyId;
  final String visitdate;
  final String srlcp;
  final String ptname;
  final String docname;
  final String phone;

  const ScannedImagesWidget({
    Key? key,
    required this.phone,
    required this.dbNamebyId,
    required this.visitdate,
    required this.srlcp,
    required this.ptname,
    required this.docname,
  }) : super(key: key);
  @override
  _ScannedImagesWidgetState createState() => _ScannedImagesWidgetState();
}

class _ScannedImagesWidgetState extends State<ScannedImagesWidget> {
  List<int> imgbytelist = [];
  @override
  Widget build(BuildContext context) {
    GridFSimageFileReaderOneVisitDate fSimageFileReader =
        GridFSimageFileReaderOneVisitDate(
            phone: widget.phone,
            ptname: widget.ptname,
            visitdate: widget.visitdate,
            srlcp: widget.srlcp,
            docname: widget.docname);
    return Scaffold(
      backgroundColor: Colors.grey[500]?.withOpacity(0.5),
      body: StreamBuilder(
          stream: fSimageFileReader.allimagesdata,
          builder: (context, snapshot) {
            List data = !snapshot.hasData ? [] : snapshot.data!;

            return Dialog(
              child: SizedBox(
                height: 600,
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Text(widget.srlcp),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 500,
                        width: 500,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1.0,
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: !snapshot.hasData ? 0 : data.length,
                            itemBuilder: (context, index) {
                              Uint8List bytelist = Uint8List.fromList(
                                  base64Decode(data[index][widget.srlcp]));
                              MemoryImage provider = MemoryImage(bytelist);

                              return data.isEmpty
                                  ? const CircularProgressIndicator()
                                  : Container(
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(5, 5),
                                              blurRadius: 5,
                                              spreadRadius: 5,
                                            )
                                          ],
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          child: Image(
                                            image: provider,
                                          ),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Card(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const SizedBox(),
                                                            Text(widget
                                                                .visitdate),
                                                            IconButton(
                                                              icon: const Icon(
                                                                  Icons.close),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  offset:
                                                                      Offset(
                                                                          5, 5),
                                                                  blurRadius: 5,
                                                                  spreadRadius:
                                                                      5,
                                                                )
                                                              ],
                                                              color: Colors
                                                                  .grey[100],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: SizedBox(
                                                            width: 1024,
                                                            height: 650,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: ListView
                                                                  .separated(
                                                                itemCount: !snapshot
                                                                        .hasData
                                                                    ? 0
                                                                    : data
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Container(
                                                                    child:
                                                                        Image(
                                                                      image:
                                                                          provider,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  );
                                                                },
                                                                separatorBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Divider(
                                                                    thickness:
                                                                        5,
                                                                    height: 20,
                                                                    color: Colors
                                                                            .primaries[
                                                                        Random().nextInt(Colors
                                                                            .primaries
                                                                            .length)],
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                        ),
                                      ),
                                    );
                            },
                          ),
                        )),
                  ]),
                ),
              ),
            );
          }),
    );
  }
}
