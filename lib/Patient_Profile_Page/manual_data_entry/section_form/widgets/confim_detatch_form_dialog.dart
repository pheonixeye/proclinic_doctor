import 'package:flutter/material.dart';

class ConfirmDetachFormDialog extends StatelessWidget {
  const ConfirmDetachFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Text('Detach "Form" From "Visit" ?'),
          const Spacer(),
          FloatingActionButton.small(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            heroTag: 'confirm-detach-form',
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      scrollable: true,
      content: const Card.outlined(
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Detaching a Form Will Also Delete Any Previously Added Data in The Form, Are You Sure ?",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(Icons.check),
          label: const Text("Confirm"),
        ),
      ],
    );
  }
}
