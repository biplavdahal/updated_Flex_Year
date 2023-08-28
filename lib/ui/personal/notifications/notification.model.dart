import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/notification.data.dart';
import 'package:flex_year_tablet/services/notification.service.dart';

class AllNotificationModel extends ViewModel with SnackbarMixin {
  //service
  final NotificationService _notificationService =
      locator<NotificationService>();

  List<NotificationData> _allNotificationData = [];
  List<NotificationData> get allNotificationData => _allNotificationData;

  Future<void> init() async {
    try {
      setLoading();
      _allNotificationData = await _notificationService.getAllNotification();
      setIdle();
    } catch (e) {
      rethrow;
    }
  }
}
