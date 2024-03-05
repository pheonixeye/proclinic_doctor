import 'package:proclinic_doctor_windows/control_panel/zTEST_TXT_open_dialog_ffi.dart';
import 'package:flutter/material.dart';

class PrintSheetPage extends StatefulWidget {
  const PrintSheetPage({super.key});

  @override
  _PrintSheetPageState createState() => _PrintSheetPageState();
}

class _PrintSheetPageState extends State<PrintSheetPage> {
  LocalStorageTextPath textpath = LocalStorageTextPath();
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map;

    List keyslist = [];
    List valueslist = [];
    data.forEach((key, value) {
      keyslist.add(key.toString());
      valueslist.add(value.toString());
    });
    return Scaffold(
      body: Builder(builder: (context) {
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: keyslist.length,
                  itemBuilder: (context, index) {
                    return Text(keyslist[index].toString());
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: valueslist.length,
                  itemBuilder: (context, index) {
                    return Text(valueslist[index].toString());
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: ElevatedButton.icon(
                  label: const Text('Print Visit Details'),
                  icon: const Icon(Icons.print),
                  onPressed: () async {
                    final printfile = CreateFileForPrint(data: data.toString());

                    await printfile.writeData();
                    await printfile.printDocAfterAddData();
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
