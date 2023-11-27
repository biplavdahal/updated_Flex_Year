// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_year_tablet/data_models/notice.data.dart';
import 'package:flex_year_tablet/data_models/notification.data.dart';

import '../data_models/all_staff_birthday.data.dart';
import '../data_models/staff_birthday.data.dart';

import '../data_models/staff_performance_allreport.dart';

abstract class NotificationService {


  /// --------- The notice API model is also implemented inside this class ----------

  // Fetch notice from /site/staffdashboard API

  NoticeData? get notice;

  Future<void> fetchNotices();

  //staff birthday
  Future<List<StaffBirthdayData>> getStaffBirthday();

  //staff performance
  Future<List<StaffPerformanceAllReportData>> getStaffPerformance();

  //upcomming Birthday
  Future<List<AllStaffBirthdayData>> getAllStaffBirthday();

  //In app notification
  Future<List<NotificationData>> getAllNotification();
}
