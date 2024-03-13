import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';

void showCustomSnackbar({
  required BuildContext context,
  required String message,
}) {
  SnackBar snackbar = SnackBar(
    duration: const Duration(milliseconds: 500),
    elevation: 10,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          message,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 50,
        ),
        const Icon(
          Icons.thumb_up,
          color: Colors.green,
        )
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

SnackBar docInfoSnackBar(Doctor doctor) {
  return SnackBar(
    duration: const Duration(seconds: 1),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Doctor :   '),
        Text(
          doctor.docnameEN.toUpperCase(),
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
      ],
    ),
  );
}

void showSelectDrugFirstSnackbar(BuildContext context, {bool isDose = false}) {
  SnackBar snackbar = SnackBar(
    duration: const Duration(milliseconds: 3000),
    elevation: 10,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          isDose
              ? "Dose Adjustment Missing."
              : 'Select a Drug Before Adjusting The Dose.',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        const Icon(
          Icons.info,
          color: Colors.yellow,
        )
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
