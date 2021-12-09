import 'dart:async';

import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.model.dart';
import 'package:flex_year_tablet/data_models/app_access.data.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flutter/material.dart';

class EnterPinModel extends ViewModel {
  // Service
  final AppAccessService _accessService = locator<AppAccessService>();

  // UI Controllers
  final TextEditingController _pinController = TextEditingController();
  TextEditingController get pinController => _pinController;

  // Data
  AppAccessData get appAccessData => _accessService.appAccess!;

  List<List<String>> get inputs => [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["", "0", "<"]
      ];

  String _currentDateTime = DateTime.now().toString();
  String get currentDateTime => _currentDateTime;

  // Action
  Future<void> init() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDateTime = DateTime.now().toString();
      setIdle();
    });
  }

  void onInputCellPressed(String pin) {
    if (pin != "<") {
      if (_pinController.text.length < 6) {
        _pinController.text += pin;
      }
    } else {
      _pinController.text =
          _pinController.text.substring(0, _pinController.text.length - 1);
    }
    setIdle();
  }
}
