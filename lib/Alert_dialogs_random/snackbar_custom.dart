import 'package:flutter/material.dart';

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
