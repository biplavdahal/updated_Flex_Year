import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flutter/cupertino.dart';

class SettingModel extends ViewModel with DialogMixin, SnackbarMixin {
  Future<void> init() async {
    
  }

  void changeDate(Locale newLocale) {
    _changeLocale(newLocale);
  }

  void _changeLocale(Locale newLocale) {
  
  }
}
