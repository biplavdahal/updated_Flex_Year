import 'package:bestfriend/bestfriend.dart';

import '../../../data_models/all_staff_birthday.data.dart';
import '../../../services/notification.service.dart';

class AllStaffBirthdayModel extends ViewModel with SnackbarMixin {
  //service
  final NotificationService _notificationService =
      locator<NotificationService>();

  List<AllStaffBirthdayData> _allStaffBirthdayData = [];
  List<AllStaffBirthdayData> get allStaffBirthdayData => _allStaffBirthdayData;

  Future<void> init() async {
    try {
      setLoading();
      _allStaffBirthdayData = await _notificationService.getAllStaffBirthday();
      setIdle();
    } catch (e) {
      rethrow;
    }
  }
}
