/// --------------------------------------------------
/// ------------- Base URL for the API ---------------
/// --------------------------------------------------
const auBaseURL = "https://dev.flexyear.com/backend/";
// const auBaseURL = "https://flexsaas.flexyear.com/";
const auApiBaseUrl = "${auBaseURL}flexyear_api/api/web/v1/";

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
const auWeeklyReport = "attendance/weekly-report";
const auGetCorrectionRequest = "userstaff/attendance";
const auForgotCheckoutReviewRequest = "attendance/checkoutreview";
const auDeleteAttendanceCorrection = "attendance/remove";
const auPostAttendanceCorrection = "attendance/correction-review";
const auAttendanceCorrectionEdit = "attendance/edit";
const auOneDayReport = "attendance/oneday-report";
const auGetAttendanceCorrectionReviews = "attendance/search";
const auPostAttendanceCorrectionReview = "attendance/status";
const auAddMultipleAttendance = "attendance/addmultiple";

const auLeaveTypes = "leavetype/index";
// This API takes user id as staff id so beaware of that.
const auLeaveSearch = "leave/search";
const auNewLeaveRequest = "leave/add";
const auRemoveLeaveRequest = "leave/remove";
const auEditLeaveRequest = "leave/edit";
const auActionOnLeaveRequest = "leave/status";

const auHolidays = "holiday/index";

const auStaffsList = "staff/index";

const auClients = "client/index";
