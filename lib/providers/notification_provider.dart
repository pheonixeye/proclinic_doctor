import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proclinic_doctor_windows/providers/overlay_provider.dart';
import 'package:proclinic_doctor_windows/widgets/notification_overlay_card.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class PxAppNotifications extends ChangeNotifier {
  PxAppNotifications() {
    fetchNotifications();
  }

  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;

  static late final Box<AppNotification> box;

  void fetchNotifications() {
    final result = box.values.toList();
    result.sort((a, b) {
      final da = DateTime.parse(a.dateTime);
      final db = DateTime.parse(b.dateTime);
      return da.isAfter(db) ? 0 : 1;
    });
    _notifications = result;
    notifyListeners();
  }

  Future<void> addNotification(
    AppNotification value,
    BuildContext context,
  ) async {
    await box.put(value.id, value).whenComplete(() {
      fetchNotifications();
    });
    if (context.mounted) {
      context.read<PxOverlay>().toggleOverlay(
            id: value.id,
            child: NotificationOverlayCard(notification: value),
            context: context,
          );
    }
  }

  Future<void> deleteNotification(String id) async {
    await box.delete(id).whenComplete(() {
      fetchNotifications();
    });
  }

  Future<void> deleteAllNotifications() async {
    await box.clear();
    fetchNotifications();
  }

  Future<void> readNotification(String id) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _isRead = _notifications.firstWhere((x) => x.id == id).copyWith(
          isRead: true,
        );
    await box.delete(id);
    await box.put(id, _isRead).whenComplete(() {
      fetchNotifications();
    });
  }
}
