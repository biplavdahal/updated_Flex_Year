/// --------------------------------------------------
/// ------------- Base URL for the API ---------------
/// --------------------------------------------------
const auBaseURL = "https://dev.flexyear.com/backend/";
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

const auLeaveTypes = "leavetype/index";
// This API takes user id as staff id so beaware of that.
const auLeaveHistory = "leave/search";
const auNewLeaveRequest = "leave/add";
