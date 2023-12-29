import 'package:flex_year_tablet/config.dart';

/// --------------------------------------------------
/// ------------- Base URL for the API ---------------
/// --------------------------------------------------
const auBaseURL = cpApiBaseURL;
// const auBaseURL = "https://flexsaas.flexyear.com/";
const auApiBaseUrl = "${auBaseURL}flexyear_api/api/web/v1/";
const auImageBaseUrl = "$auBaseURL/public/images/";

/// --------------------------------------------------
/// ---------------  API Endpoints -------------------
/// --------------------------------------------------
const auAppAccess = "appaccess/index";
const auAppAccessClientCode = "appaccess/clientcode";

const auUserLogin = "user/login";
const auUserPinLogin = "user/pinlogin";
const auUserLogout = "user/logout";

const auAttendanceStatus = "attendance/attstatus";
const auAttendanceForgot = "attendance/forgottocheckout";
const auAttendanceInOut = "attendance/inout";
const auMonthlyAttendanceReport = "attendance/reportclient";
const auAttendanceSummary = "userstaff/staff-attendance";
const auUserStaffDetail = "userstaff/index";
const auWeeklyReport = "attendance/weekly-report";
const auGetRequest = "userstaff/attendance";
const auGetPresentStaff = 'attendance/presentstaff';

///
const auForgotCheckoutReviewRequest = "attendance/checkoutreview";
const auDeleteAttendanceCorrection = "attendance/remove";
const auPostAttendanceCorrection = "attendance/correction-review";

///today attendance correction review
const auPostAttendanceRequestReview = "attendance/correction";

const auAttendanceCorrectionEdit = "attendance/edit";
const auOneDayReport = "attendance/oneday-report";
const auGetAttendanceCorrectionReviews = "attendance/search";
const auPostAttendanceCorrectionReview = "attendance/status";
const auAddMultipleAttendance = "attendance/addmultiple";

const auLeaveTypes = "leavetype/index";
const auLeaveTypesEdit = "leavetype/edit";
const auLeaveTypesRemove = "leavetype/remove";
// This API takes user id as staff id so beaware of that.
const auLeaveSearch = "leave/search";
const auNewLeaveRequest = "leave/add";
const auRemoveLeaveRequest = "leave/remove";
const auEditLeaveRequest = "leave/edit";
const auActionOnLeaveRequest = "leave/status";

const auHolidays = "holiday/index";

const auStaffsList = "staff/index";

const auClients = "client/index";
//payroll's API
const auPayrollSearch = "payroll/search";
const auPayrollHistory = "payroll/history";

//Notification's API
const auStaffDashboard = "site/staffdashboard";
const auStaffBirthday = "site/birthday";
const auNotificationList = 'notification/list';

const auFCMNotificationPost = "token/post";
//performance report
const auStaffPerformance = "performance/list";

//update profile
const auUpdateProfile = "staff/upload";
const auChangePassword = "staff/changepassword";

// ------ TABLET SPECIFIC API ------
const auGetPins = "appaccess/pin";
const auTabletAttendanceStatus = "appaccess/attstatus";
const auTabletPostAttendance = "appaccess/inout";
const auTabletSync = "appaccess/bulkinout";

// ----- CHAT API ------
const auGetContactLists = "message/accessmessage";
const auSendAttachmentMessage = "message/upload";
const auGetMessages = "message/index";
const auSendTextMessage = "message/post";

// ----- Reset password ----
const auRequestResetPassword = "user/request-password-reset";

//-------Staff api---------
const auStaffDetail = "staff/details";

//Staff Directory
const austaffDepartmentIndex = 'department/index';
const auStaffDepartmentDetailList = 'department/search';

//--------Exit Process-----
const auStaffGetResign = 'resignation-letter/index';
const auStaffPostResign = 'resignation-letter/add';
const auStaffGetClearance = 'user-clearances/search';

//Questions and answer
const auStaffGetQuestion = 'exit-survey/index';
