import 'package:flutter/material.dart';
import 'package:proclinic_doctor/functions/format_time.dart';
import 'package:proclinic_models/proclinic_models.dart';

class PreviewVisitDialog extends StatelessWidget {
  const PreviewVisitDialog({super.key, required this.visit});
  final Visit visit;
  final _titleTextStyle = const TextStyle(
    decoration: TextDecoration.underline,
  );
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8,
      alignment: Alignment.bottomRight,
      //todo: STYLE
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      visit.ptName,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 30),
                    IconButton.outlined(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Visit Date",
                      style: _titleTextStyle,
                    ),
                    const SizedBox(width: 30),
                    SelectableText(formatDateWithoutTime(visit.visitDate)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Visit Type",
                      style: _titleTextStyle,
                    ),
                    const SizedBox(width: 30),
                    SelectableText(visit.visitType),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Paid",
                      style: _titleTextStyle,
                    ),
                    const SizedBox(width: 30),
                    SelectableText("${visit.amount} L.E."),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Paid",
                      style: _titleTextStyle,
                    ),
                    const SizedBox(width: 30),
                    SelectableText("${visit.remaining} L.E."),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Affiliate",
                      style: _titleTextStyle,
                    ),
                    const SizedBox(width: 30),
                    SelectableText(visit.affiliate.affiliateEn),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Contract",
                      style: _titleTextStyle,
                    ),
                    const SizedBox(width: 30),
                    SelectableText(visit.contract.nameEn),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    Text(
                      "Procedures",
                      style: _titleTextStyle,
                    ),
                    const SizedBox(width: 30),
                    ...visit.procedures.map((e) {
                      return SelectableText("${e.nameEn},");
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Update Time",
                      style: _titleTextStyle,
                    ),
                    const SizedBox(width: 30),
                    SelectableText(formatDate(DateTime.now().toIso8601String()))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
