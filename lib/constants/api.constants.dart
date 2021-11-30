/// --------------------------------------------------
/// ------------- Base URL for the API ---------------
/// --------------------------------------------------
// const auBaseURL = "https://dev.flexyear.com/backend/";
const auBaseURL = "https://flexsaas.flexyear.com/";
const auApiBaseUrl = "${auBaseURL}flexyear_api/api/web/v1/";

/// --------------------------------------------------
/// ---------------  API Endpoints -------------------
/// --------------------------------------------------
const auAppAccess = "appaccess/index";

const auUserLogin = "user/login";
const auUserPinLogin = "user/pinlogin";
const auUserLogout = "user/logout";

const auAttendanceStatus = "attendance/attstatus";
const auAttendanceForgot = "attendance/forgottocheckout";
const auAttendanceInOut = "attendance/inout";
const auMonthlyAttendanceReport = "attendance/reportclient";
const auAttendanceSummary = "userstaff/staff-attendance";
const auWeeklyReport = "attendance/weekly-report";

const auLeaveTypes = "leavetype/index";
// This API takes user id as staff id so beaware of that.
const auLeaveHistory = "leave/search";
const auNewLeaveRequest = "leave/add";
const auRemoveLeaveRequest = "leave/remove";
const auEditLeaveRequest = "leave/edit";

const auHolidays = "holiday/index";
