import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Alert_dialogs_random/snackbar_custom.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';
import 'package:proclinic_doctor_windows/providers/doctorListProvider.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

class NewlyFormatedDoctorsDropDownButton extends StatefulWidget {
  const NewlyFormatedDoctorsDropDownButton({super.key});

  @override
  _NewlyFormatedDoctorsDropDownButtonState createState() =>
      _NewlyFormatedDoctorsDropDownButtonState();
}

class _NewlyFormatedDoctorsDropDownButtonState
    extends State<NewlyFormatedDoctorsDropDownButton> {
  Doctor? _doctor;

  @override
  Widget build(BuildContext context) {
    return Consumer<PxDoctorListProvider>(
      builder: (context, doctors, c) {
        while (doctors.doctorList == null) {
          return const LinearProgressIndicator();
        }
        List<DropdownMenuItem<Doctor>> _items = [];
        for (int i = 0; i < doctors.doctorList!.length; i++) {
          _items.add(
            DropdownMenuItem<Doctor>(
              value: doctors.doctorList![i],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    doctors.doctorList![i].docnameEN.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(doctors.doctorList![i].clinicEN),
                ],
              ),
            ),
          );
        }
        return SizedBox(
          height: 50.0,
          child: Container(
            decoration: ThemeConstants.cd,
            child: DropdownButton<Doctor>(
              hint: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select Clinic . . .'),
                ],
              ),
              value: _doctor,
              items: _items,
              onChanged: (value) async {
                ScaffoldMessenger.of(context)
                    .showSnackBar(docInfoSnackBar(value!));
                setState(() {
                  _doctor = value;
                });
                context.read<PxSelectedDoctor>().selectDoctor(value);
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
