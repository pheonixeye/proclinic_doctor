import 'package:proclinic_doctor_windows/Patient_Profile_Page/previous_visits/popupmenubutton_custom.dart';
import 'package:flutter/material.dart';

class PreviousVisitsPage extends StatefulWidget {
  const PreviousVisitsPage({super.key});

  @override
  _PreviousVisitsPageState createState() => _PreviousVisitsPageState();
}

class _PreviousVisitsPageState extends State<PreviousVisitsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          // print(snapshot.data);

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Scaffold(
              appBar: AppBar(
                leading: const SizedBox.shrink(),
                title: const Text(
                  'Previous Visits :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              body: StreamBuilder(
                stream: null,
                builder: (context, snapshot) {
                  final data1 = snapshot.data as List;

                  // print(' returned data ==>> ${data1}');
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      List? medinfolist = data1[index]['medinfo'];

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        trailing: CustomPOPUPBUTTON(
                          callUpdate: () {},
                          callPrint: () {},
                          callPresc: () {},
                        ),
                        title: Card(
                          elevation: 10,
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 30,
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${data1[index]['ptname']}',
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 30,
                                      child: Icon(Icons.calendar_today),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${data1[index]['day']}-${data1[index]['month']}-${data1[index]['year']}',
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                        subtitle: Card(
                          elevation: 10,
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: medinfolist == null
                                  ? 0.0
                                  : medinfolist.length * 150.0.toDouble(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.separated(
                                  itemCount: medinfolist == null
                                      ? 0
                                      : medinfolist.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        tileColor: Colors.grey[300],
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.purple[500]
                                              ?.withOpacity(0.5),
                                        ),
                                        title: FractionallySizedBox(
                                          alignment: Alignment.topLeft,
                                          widthFactor: medinfolist![index]
                                                  .keys
                                                  .toString()
                                                  .length /
                                              50.toDouble(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      offset: Offset(2, 2),
                                                      spreadRadius: 2,
                                                      blurRadius: 2)
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  medinfolist[index]
                                                      .keys
                                                      .toString()
                                                      .substring(
                                                          1,
                                                          medinfolist[index]
                                                                  .keys
                                                                  .toString()
                                                                  .length -
                                                              1),
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              medinfolist[index]
                                                  .values
                                                  .toString()
                                                  .substring(
                                                      1,
                                                      medinfolist[index]
                                                              .values
                                                              .toString()
                                                              .length -
                                                          1),
                                              style:
                                                  const TextStyle(fontSize: 24),
                                            ),
                                          ),
                                        ),
                                        trailing: IconButton(
                                          tooltip: 'Delete Entry',
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          ),
                                          onPressed: () async {
                                            //TODO: make delete entry function
                                            await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return _dialog;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      color: Colors.blueGrey,
                                      thickness: 3,
                                      height: 10,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: !snapshot.hasData ? 0 : data1.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.blueGrey,
                        thickness: 5,
                        height: 15,
                      );
                    },
                  );
                },
              ),
            ),
          );
        });
  }
}

final _dialog = AlertDialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  title: const Text('Delete Entry ??'),
  content: const SingleChildScrollView(
    child: Text(
        'Deleting this entry makes this data no longer available. \n Are You Sure ?'),
  ),
  actions: [
    ElevatedButton.icon(
      icon: const Icon(
        Icons.check,
        color: Colors.green,
      ),
      label: const Text('Confirm'),
      onPressed: () async {},
    ),
    ElevatedButton.icon(
      icon: const Icon(
        Icons.cancel,
        color: Colors.red,
      ),
      label: const Text('Cancel'),
      onPressed: () {},
    ),
  ],
);
