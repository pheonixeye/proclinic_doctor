import 'package:flutter/material.dart';
import 'package:proclinic_doctor/providers/form_loader.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class VisitFormDataDialog extends StatelessWidget {
  const VisitFormDataDialog({super.key, required this.visit});
  final Visit visit;

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
                    Consumer<PxFormLoader>(
                      builder: (context, f, _) {
                        final form =
                            f.forms?.firstWhere((x) => x.id == visit.formId);
                        return Text(
                          form?.titleEn ?? "",
                          style: const TextStyle(fontSize: 18),
                        );
                      },
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
              if (visit.formData != null)
                ...visit.formData!.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "${e.key} : ${e.value.toString()}"),
                        ],
                      ),
                    ),
                  );
                })
            ],
          ),
        ),
      ),
    );
  }
}
