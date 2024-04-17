import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrDialog extends StatelessWidget {
  const QrDialog({super.key, required this.code});
  final QrCode code;
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        children: [
          const Text('QR Code'),
          const Spacer(),
          IconButton.filled(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrettyQrView(
            qrImage: QrImage(
              code,
            ),
            decoration: const PrettyQrDecoration(
              background: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
