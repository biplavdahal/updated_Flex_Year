import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class DateConverterViewModel extends ViewModel with DialogMixin, SnackbarMixin {
  //UI components

  DateTime? _dateFrom;
  DateTime? get dateFrom => _dateFrom;
  DateTime? _dateTo;
  DateTime? get dateTo => _dateTo;
  set dateFrom(DateTime? value) {
    _dateFrom = value;
    if (_dateFrom != null) {
      NepaliDateTime nepaliDateTimeT = NepaliDateTime.fromDateTime(_dateFrom!);
      _dateTo = nepaliDateTimeT;
    }
    if (_dateFrom == null) {
      _dateTo = "" as DateTime?;
    }
    setIdle();
  }

  NepaliDateTime? _nepaliDateFrom;
  NepaliDateTime? get nepaliDateFrom => _nepaliDateFrom;

  DateTime? _nepaliDateTo;
  DateTime? get nepaliDateTo => _nepaliDateTo;
  set nepaliDateFrom(NepaliDateTime? value) {
    _nepaliDateFrom = value;
    _nepaliDateTo = nepaliDateFrom?.toDateTime();
    setIdle();
  }
}
