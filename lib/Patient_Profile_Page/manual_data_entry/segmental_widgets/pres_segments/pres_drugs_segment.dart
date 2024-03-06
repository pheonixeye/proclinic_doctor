import 'package:flutter/material.dart';

// _DrugGetterSegmentState drugGetterSegmentState = _DrugGetterSegmentState();
// final GlobalKey<DrugGetterSegmentState> druggetstatekey = GlobalKey();

class DrugGetterSegment extends StatefulWidget {
  final Map forwardedData;
  final Function callback;

  const DrugGetterSegment({
    Key? key,
    required this.forwardedData,
    required this.callback,
  }) : super(key: key);
  // DrugGetterSegment({this.callback, this.forwardedData});
  @override
  DrugGetterSegmentState createState() => DrugGetterSegmentState();
}

class DrugGetterSegmentState extends State<DrugGetterSegment> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          final data = !snapshot.hasData ? [] : snapshot.data as List;

          return ListView.builder(
            itemCount: !snapshot.hasData ? 0 : data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(child: Text('Rx')),
                title: Text(data[index].toString()),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    //TODO: delete drug entry
                  },
                ),
              );
            },
          );
        });
    // });
  }
}
