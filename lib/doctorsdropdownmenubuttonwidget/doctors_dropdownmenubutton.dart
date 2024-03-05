import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Mongo_db_doctors/mongo_doctors_db.dart';

late String globallySelectedDoctor;
late String globallySelectedClinic;

class NewlyFormatedDoctorsDropDownButton extends StatefulWidget {
  const NewlyFormatedDoctorsDropDownButton({super.key});

  @override
  _NewlyFormatedDoctorsDropDownButtonState createState() =>
      _NewlyFormatedDoctorsDropDownButtonState();
}

class _NewlyFormatedDoctorsDropDownButtonState
    extends State<NewlyFormatedDoctorsDropDownButton> {
  DoctorsMongoDatabase doctormongo = DoctorsMongoDatabase();
  int? intselval;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: doctormongo.allDoctorsfromMongo,
      builder: (context, snapshot) {
        List? data = !snapshot.hasData ? [] : snapshot.data;
        // print(data);
        List data_ = [];

        //the data_ list is added to avoid the .length method was called on null
        data_.addAll(data!);

        List<DropdownMenuItem<int>> _items = [];
        for (int i = 0; i < data_.length; i++) {
          _items.add(DropdownMenuItem<int>(
            value: i,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                data[i]['docname'].toString().toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(data[i]['clinic'].toString())
            ]),
          ));
        }
        return SizedBox(
          height: 50.0,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(4.0, 4.0),
                  blurRadius: 4.0,
                ),
              ],
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<int>(
              hint: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Select Clinic . . .')],
              ),
              value: intselval,
              items: _items,
              onChanged: (value) async {
                final snackbar = SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Doctor :   '),
                          Text(
                            '${data[value!]['docname']}   '.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('selected.'),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.thumb_up_alt_rounded,
                            color: Colors.green,
                          )
                        ]));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                setState(() {
                  intselval = value;
                  globallySelectedDoctor = data[intselval!]['docname'];
                  globallySelectedClinic = data[intselval!]['clinic'];
                  print('---------------------${globallySelectedDoctor}');
                });
              },
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              icon: const Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.blue,
              ),
              isExpanded: true,
            ),
          ),
        );
      },
    );
  }
}
