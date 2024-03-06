import 'package:flutter/material.dart';

class RadGetterSegment extends StatefulWidget {
  final Map forwardedData;
  final Function callback;

  const RadGetterSegment(
      {Key? key, required this.forwardedData, required this.callback})
      : super(key: key);
  @override
  RadGetterSegmentState createState() => RadGetterSegmentState();
}

class RadGetterSegmentState extends State<RadGetterSegment> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          List data = !snapshot.hasData ? [] : snapshot.data as List;

          return ListView.builder(
            itemCount: !snapshot.hasData ? 0 : data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(child: Text('R')),
                title: Text(
                  data[index].toString(),
                  style: const TextStyle(fontSize: 14),
                ),
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
  }
}
