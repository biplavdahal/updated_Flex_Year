import 'package:flex_year_tablet/data_models/leave_request.data.dart';

abstract class LeaveService {
  /// Create new leave
  Future<void> createLeaveRequest(Map<String, dynamic> leaveData);
  
  /// Update leave request
  Future<void> updateLeaveRequest(Map<String, dynamic> leaveData);

  /// Get all leave requests
  Future<List<LeaveRequestData>> getAllLeaveRequests();

  /// Delete leave request
  Future<void> deleteLeaveRequest(
    String id,
  );
}
