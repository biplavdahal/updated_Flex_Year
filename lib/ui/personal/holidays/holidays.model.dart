import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/holiday.data.dart';
import 'package:flex_year_tablet/services/company.service.dart';

class HolidaysModel extends ViewModel with SnackbarMixin {
  // Service
  static final CompanyService _companyService = locator<CompanyService>();

  // Data
  static List<HolidayData> get holiday => _companyService.holidays;

  // Actions
  Future<void> init() async {
    try {
      setLoading();
      final _holidays = await _companyService.getHolidays();
      _companyService.holidays = _holidays;

      // _holidays = await _companyService.getHolidays();

      setIdle();
    } catch (e) {
      // setIdle();
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: e.toString(),
        ),
      );
    }
  }

  static Future<void> holidaydata() async {
    final _holidays = await _companyService.getHolidays();
    _companyService.holidays = _holidays;
  }
}
