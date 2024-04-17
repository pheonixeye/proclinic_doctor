import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/providers/notification_provider.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.item,
    required this.index,
  });
  final AppNotification item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: item.isRead ? Colors.blue : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${index + 1} "),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    item.titleEn,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      await EasyLoading.show(status: "Loading...");
                      if (context.mounted) {
                        await context
                            .read<PxAppNotifications>()
                            .readNotification(item.id);
                      }
                      await EasyLoading.dismiss();
                    },
                    child: SelectableText(
                      item.descriptionEn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              IconButton.filled(
                onPressed: () async {
                  await EasyLoading.show(status: "Loading...");
                  if (context.mounted) {
                    await context
                        .read<PxAppNotifications>()
                        .deleteNotification(item.id);
                  }
                  await EasyLoading.dismiss();
                },
                icon: const Icon(Icons.delete),
              ),
              const SizedBox(
                height: 30,
              ),
              IconButton.filled(
                onPressed: () async {
                  await EasyLoading.show(status: "Loading...");
                  if (context.mounted) {
                    await context
                        .read<PxAppNotifications>()
                        .readNotification(item.id);
                  }
                  await EasyLoading.dismiss();
                },
                icon: item.isRead
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
