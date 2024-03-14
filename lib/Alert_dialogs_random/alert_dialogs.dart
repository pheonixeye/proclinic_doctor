import 'package:flutter/material.dart';

//wrong password dialog//
//---------------------//
showAlertDialogWrongPassword(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text('Wrong password !!!'),
    content: const Text('Kindly check spelling and capitalization.'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//select doctor first dialog//
//-------------------------//
showAlertDialogselectdoctorfirst(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text('No clinic selected !!!'),
    content: const Text('Kindly Select clinic first.'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//passwords not matching dialog//
//-------------------------//
showAlertDialogpasswordsnotmatching(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text('Password not matching !!!'),
    content: const Text('Kindly check spelling and capitalization.'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//password updated dialog//
//-------------------------//
showAlertDialogpasswordupdatecomplete(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text('Password Updated !!!'),
    content: const Text('Kindly Login.'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
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
