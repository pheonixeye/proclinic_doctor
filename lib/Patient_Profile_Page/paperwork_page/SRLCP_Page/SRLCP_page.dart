import 'package:proclinic_doctor_windows/Patient_Profile_Page/paperwork_page/SRLCP_Page/show_scanned_images.dart';
import 'package:flutter/material.dart';

class SRLCP extends StatefulWidget {
  final String scrlp;

  const SRLCP({Key? key, required this.scrlp}) : super(key: key);
  @override
  _SRLCPState createState() => _SRLCPState();
}

class _SRLCPState extends State<SRLCP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Builder(
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text('ptname'),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 5,
                  thickness: 5,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 500,
                  child: StreamBuilder(
                    stream: null,
                    builder: (context, snapshot) {
                      final data = snapshot.data! as List<Map<String, dynamic>>;
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text('${index + 1}'),
                                ),
                                title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(data[index]['clinic']),
                                    ]),
                                subtitle: Text(
                                    '${data[index]['day']}-${data[index]['month']}-${data[index]['year']}'),
                                trailing: ElevatedButton.icon(
                                  icon: const Icon(Icons.poll),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ScannedImagesWidget(
                                          phone: data[index]['phone'],
                                          docname: data[index]['docname'],
                                          visitdate:
                                              '${data[index]['day']}${data[index]['month']}${data[index]['year']}',
                                          srlcp: widget.scrlp.toLowerCase(),
                                          dbNamebyId: data[index]['id'],
                                          ptname: data[index]['ptname'],
                                        ),
                                      ),
                                    );
                                  },
                                  label: Text(
                                      'SHOW ${widget.scrlp}'.toUpperCase()),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.blueGrey,
                            thickness: 5,
                            height: 5,
                          );
                        },
                        itemCount: !snapshot.hasData ? 0 : data.length,
                      );
                    },
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 5,
                  height: 5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
